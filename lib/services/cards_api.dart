
import 'package:baseball_cards/models/card.dart';

abstract class CardsApi {

  Future<List<Card>> getAll();

  Future<Card> getById( String id );

  Future<Card> save( Card card );

  Future<Card> update( String cardId, Card card );
  
  Future<void> delete( String id );

}