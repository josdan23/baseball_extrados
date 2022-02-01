
import 'package:baseball_cards/models/card.dart' ;
import 'package:baseball_cards/data/repositories/card_repo.dart';
import 'package:baseball_cards/services/cards_api.dart';


class CardController { 

  late final CardRepo repo;

  CardController( CardsApi dataSource ) {
    repo = CardRepo.getInstance(dataSource);
  }


  Future<List<Card>> getAllCards() async {

    List<Card> cardList = await repo.getAllCards();
    
    return cardList;
  }


  Future<Card> getCardById( String cardId) async {

    final card = await repo.getCardById( cardId );

    return card;
  }


  Future<Card> saveNewCard( Card newCard ) async {

    final newCardSaved = await repo.save( newCard );

    return newCardSaved;
  }


  Future<void> deleteCard( String cardId ) async {

    await repo.delete( cardId );
  }


  Future<Card> updateCard( String cardId, Card cardToUpdate ) async {

    final cardUpdated = await repo.update(cardId, cardToUpdate );

    return cardUpdated!;

  }


  //XXX FEATURE: buscar cartas por alguna propiedad.
  Future<Card> searchCard( String query) async {

    throw Exception('No implementado');
  }

  

}