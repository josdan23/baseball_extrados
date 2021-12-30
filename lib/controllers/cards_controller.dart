
import 'package:baseball_cards/models/card.dart' ;
import 'package:baseball_cards/services/cards_api.dart';


class CardController { 

  final CardsApi cardsApi;

  CardController(this.cardsApi);


  Future<List<Card>> getAllCards() async {

    List<Card> cardList = await cardsApi.getAll();
    
    return cardList;
  }


  Future<Card> getCardById( String cardId) async {

    final Card card = await cardsApi.getById( cardId );

    return card;
  }


  Future<Card> saveNewCard( Card newCard ) async {

    final Card cardSaved = await cardsApi.save( newCard );

    return cardSaved;
  }


  Future<void> deleteCard( String cardId ) async {

    await cardsApi.delete( cardId );
  }


  Future<Card> updateCard( String cardId, Card cardToUpdate ) async {

    final Card cardUpdated = await cardsApi.update( cardId, cardToUpdate );

    return cardUpdated;

  }


  //XXX FEATURE: buscar cartas por alguna propiedad.
  Future<Card> searchCard( String query) async {

    throw Exception('No implementado');
  }

  

}