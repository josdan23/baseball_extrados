
import 'package:baseball_cards/data/repositories/collection_repo.dart';
import 'package:baseball_cards/data/repositories/player_repo.dart';
import 'package:baseball_cards/data/repositories/raritie_repo.dart';
import 'package:baseball_cards/data/repositories/roles_player_repo.dart';
import 'package:baseball_cards/data/repositories/serie_repo.dart';
import 'package:baseball_cards/data/repositories/team_repo.dart';
import 'package:baseball_cards/data/repositories/user_repo.dart';
import 'package:baseball_cards/models/card.dart' ;
import 'package:baseball_cards/data/repositories/card_repo.dart';
import 'package:baseball_cards/models/collection_card.dart';
import 'package:baseball_cards/models/player.dart';
import 'package:baseball_cards/models/rarities.dart';
import 'package:baseball_cards/models/role_player.dart';
import 'package:baseball_cards/models/serie.dart';
import 'package:baseball_cards/models/team.dart';
import 'package:baseball_cards/services/cards_api.dart';
import 'package:baseball_cards/services/firebase/collection_firebase_service.dart';
import 'package:baseball_cards/services/firebase/player_firebase_services.dart';
import 'package:baseball_cards/services/firebase/rarities_firebase_services.dart';
import 'package:baseball_cards/services/firebase/roles_player_firebase_service.dart';
import 'package:baseball_cards/services/firebase/serie_firebase_services.dart';
import 'package:baseball_cards/services/firebase/team_firebase_service.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';
import 'package:baseball_cards/services/users_api.dart';


class CardController { 

  late final CardRepo _cardRepo;
  late final UserRepo _userRepo;

  CardController( CardsApi dataSource, UserApi userDataSource ) {
    _cardRepo = CardRepo.getInstance(dataSource);
    _userRepo = UserRepo.getInstance(userDataSource);
  }


  Future<Card> createCard( String lastName, String firstName, String idSerie, String idRarity, String idTeam, String idRolePlayer, List<String> idCollectionsList )  async  {

    final Serie serie = await SerieRepo.getInstance( SerieFirebaseService() ).getSerieById(idSerie);
    final Rarities rarity = await RaritieRepo.getInstance( RaritiesFirebaseServices()). getRaritieById(idRarity);
    final Team team = await TeamRepo.getInstance( TeamFirebaseService() ).getTeamById(idTeam);
    final RolePlayer rolePlayer = await RolePlayerRepo.getInstance( RolesPlayerFirebaseServices() ).getRolePlayerById( idRolePlayer);

    Player player = Player( lastName: lastName, firstName: firstName);
    Player playerSaved = await PlayerRepo.getInstance( PlayerFirebaseService()).save(player);

    List<CollectionCard> collections = [];

    for (var idCollection in idCollectionsList) {
      
      final CollectionCard coll  = await CollectionRepo.getInstance(CollectionFirebaseService()).getCollectionById( idCollection );

      collections.add( coll );
    }

    final Card newCard = Card(
        serie: serie,
        player: playerSaved,
        rarities: rarity,
        team: team,
        rolPlayer: rolePlayer ,
        collection: collections);

      return newCard;

  }

  Future<List<Card>> getAllCards() async {

    List<Card> cardList = await _cardRepo.getAllCards();
    
    return cardList;
  }


  Future<List<Card>> getAllCardsByUser() async {

    final repoUser = UserRepo.getInstance(UserFirebaseService());

    final List<Card> cards = [];
    
    for (var idCard in repoUser.userAuthenticated.cardList) {

      var card = await getCardById( idCard );

      cards.add( card );

    }
      
    
    return cards;

  }


  Future<Card> getCardById( String cardId) async {

    final card = await  _cardRepo.getCardById( cardId );

    return card;
  }


  Future<Card> saveNewCard( Card newCard ) async {

    final newCardSaved = await  _cardRepo.save( newCard );

    final userAuth = _userRepo.userAuthenticated;
    userAuth.cardList.add( newCardSaved.idCard! );
    _userRepo.update(userAuth.id!, userAuth);

    return newCardSaved;
  }


  Future<void> deleteCard( String cardId ) async {

    await  _cardRepo.delete( cardId );

    final userAuth = _userRepo.userAuthenticated;
    print(userAuth);
    userAuth.cardList.remove( cardId );
    _userRepo.update(userAuth.id!, userAuth);

    
  }


  Future<Card> updateCard( String cardId, Card cardToUpdate ) async {

    final cardUpdated = await  _cardRepo.update(cardId, cardToUpdate );

    return cardUpdated!;

  }


  Future exchangeCard( String userReceptorId, String cardExchangeId) async {

    final userReceptor = await _userRepo.getUserById( userReceptorId );
    userReceptor.cardList.add(cardExchangeId);
    await _userRepo.update(userReceptorId, userReceptor);

    final loggedUser = _userRepo.userAuthenticated;
    loggedUser.cardList.remove( cardExchangeId );
    await _userRepo.update( loggedUser.id!, loggedUser);

  }


  //XXX FEATURE: buscar cartas por alguna propiedad.
  Future<Card> searchCard( String query ) async {

    throw Exception('No implementado');
  }

  

}