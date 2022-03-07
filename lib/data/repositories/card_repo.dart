
import 'package:baseball_cards/models/card.dart';
import 'package:baseball_cards/services/cards_api.dart';
import 'package:baseball_cards/services/mappers/card_mapper.dart';
import 'package:logger/logger.dart';

class CardRepo {

  final List<Card> _cardList = [];
  final CardsApi _dataSource;

  final Logger _logger = Logger();

  static CardRepo? _INSTANCE;

  static CardRepo getInstance( CardsApi dataSource ) {

    _INSTANCE ??= CardRepo._internal( dataSource );
    return _INSTANCE!;

  }

  CardRepo._internal( CardsApi dataSource ) : this._dataSource = dataSource;


  Future<List<Card>> getAllCards() async {

    try {

      final Map<String, dynamic> dataJson = await _dataSource.getAll();

      final mapper = CardMapper();

      dataJson.forEach((key, value) {
        
        //todo: cambiar de nombre los id mapper de cada objeto
        final Card cardMapped = mapper.fromMap( value );
        cardMapped.idCard = key;

        bool  add = true;
        for (Card cardCached in _cardList) {
          if ( cardCached.idCard == cardMapped.idCard ) {
            add = false;
            break;
          }
        }

        if ( add ){
          _cardList.add( cardMapped );
        }

      });

      return _cardList;

    } catch ( e ) {
      _logger.e( e );
      throw Exception('No se puede recuperar la lista de cartas');
    }

  }

  Future<Card> getCardById( String id ) async {

    for (var oneCard in _cardList) {
      if (oneCard.idCard == id ){
        return oneCard;
      }
    }

    try {

      final dataJson = await _dataSource.getById( id );

      final cardMapped = CardMapper().fromMap( dataJson );
      cardMapped.idCard = id;

      _cardList.add( cardMapped );
      
      return cardMapped;

    } catch( e ) {
      _logger.e( e );
      throw Exception('No se pudo recuperar card id: $id del repo' );
    }
  }

  Future<Card> save( Card newCard ) async {

    try {
      
      final dataJson = await _dataSource.save( newCard );

      final id = dataJson['name'];

      newCard.idCard = id;

      _cardList.add( newCard );

      return newCard;
    
    } catch (e) {
      _logger.e( e );
      throw Exception('No se pudo crear la carta en el repo');
    }
  }

  Future<bool> delete( String id ) async {
    
    try {

      await _dataSource.delete( id );

      _cardList.removeWhere((element) => element.idCard == id);

      return true;

    } catch (e) {
      _logger.e( e );
      throw Exception('No se pudo eliminar la carta en el repo.');
    }
  }

  Future<Card?> update( String id, Card cardToUpdate ) async {

    try {

      cardToUpdate.idCard = null;
      final dataJson = await _dataSource.update( id , cardToUpdate );
      
      final Card cardUpdated = CardMapper().fromMap(dataJson);
      cardUpdated.idCard = id;

      for (var oneCard in _cardList) {
        if (oneCard.idCard == id) {
          oneCard.serie = cardUpdated.serie;
          oneCard.player = cardUpdated.player;
          oneCard.rarities = cardUpdated.rarities;
          oneCard.team = cardUpdated.team;
          oneCard.rolPlayer = cardUpdated.rolPlayer;
          oneCard.collection = cardUpdated.collection;
          oneCard.image = cardUpdated.image;
          
          return oneCard;
        }
      }
    
    } catch (e) {
      _logger.e( e );
      throw Exception( 'No se pudo actualizar la carta en el repo.' );
    }

  }


}