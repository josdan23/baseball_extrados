
import 'package:baseball_cards/models/card.dart';

abstract class CardsApi {

  Future getAll();

  Future getById( String id );

  Future save( Card card );

  Future update( String cardId, Card card );
  
  Future delete( String id );

}