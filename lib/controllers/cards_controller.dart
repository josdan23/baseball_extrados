
import 'package:baseball_cards/data/repositories/user_repo.dart';
import 'package:baseball_cards/models/card.dart' ;
import 'package:baseball_cards/data/repositories/card_repo.dart';
import 'package:baseball_cards/services/cards_api.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';
import 'package:baseball_cards/services/users_api.dart';


class CardController { 

  late final CardRepo _cardRepo;
  late final UserRepo _userRepo;

  CardController( CardsApi dataSource, UserApi userDataSource ) {
    _cardRepo = CardRepo.getInstance(dataSource);
    _userRepo = UserRepo.getInstance(userDataSource);
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
    userAuth.cardList.remove( cardId );
    _userRepo.update(userAuth.id!, userAuth);

    
  }


  Future<Card> updateCard( String cardId, Card cardToUpdate ) async {

    final cardUpdated = await  _cardRepo.update(cardId, cardToUpdate );

    return cardUpdated!;

  }


  //XXX FEATURE: buscar cartas por alguna propiedad.
  Future<Card> searchCard( String query ) async {

    throw Exception('No implementado');
  }

  

}