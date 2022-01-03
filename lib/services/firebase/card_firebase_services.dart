
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';



import 'package:baseball_cards/services/mappers/card_mapper.dart';
import 'package:baseball_cards/services/config/server.dart';
import 'package:baseball_cards/models/card.dart' ;
import 'package:baseball_cards/services/cards_api.dart';

//TODO: MANEJAR LOS CODIGOS DE RESPONSE
class CardFirebaseServices extends CardsApi {

  final Logger logger = Logger();

  @override
  Future<List<Card>> getAll() async {

    final url = Uri.https( URL_SERVER, 'cards.json');
    final response = await http.get( url );
    
    logger.d('RESPONSE_API_GET_ALL_CARDS: ${response.body}');

    final Map<String, dynamic> cardsMap = json.decode( response.body );
    
    List<Card> cardList = CardMapper().fromMapToList( cardsMap );

    logger.i('REQUIRE_GET_ALL_CARDS_OK: $cardList');

    return cardList;
    
  }
  

  @override
  Future<Card> getById(String id) async {
    
    final url = Uri.https( URL_SERVER, 'cards/$id.json' );
    final response = await http.get(url);

    logger.d('RESPONSE_API_GET_CARD_BY_ID: ${response.body}');

    final Map<String, dynamic> cardMap = json.decode( response.body );

    Card card = CardMapper().fromMap( cardMap );

    return card;

  }

  @override
  Future<Card> save(Card card) async {

    final url = Uri.https( URL_SERVER, 'cards.json');
    final response = await http.post( 
      url, 
      body: CardMapper().toJson(card)
    );

    logger.d('RESPONSE_API_SAVE_NEW_CARD: ${response.body}');

    final responseMap = json.decode( response.body );

    card.idCard = responseMap['name'];
  
    logger.i('REQUIRE_SAVE_NEW_CARD_OK: ${card.toString()}');

    return card;
  }

  @override
  Future<Card> update( String cardId, Card card) async {
    
    final url = Uri.https( URL_SERVER, 'cards/$cardId.json');
    final response = await http.patch( 
      url, 
      body: CardMapper().toJson( card ) 
    );

    logger.d('RESPONSE_API_UPDATE_CARD: ${response.body}');

    final cardUpdated = CardMapper().fromMap( json.decode(response.body ));

    logger.i('REQUIRE_UDPATED_CARD_OK: $cardUpdated');

    return cardUpdated;

  }

  @override
  Future<void> delete(String id) async {
    
    final url = Uri.https( URL_SERVER, 'cards/$id.json');
    final response = await http.delete( url );

    logger.d('REPONSE_API_DELETE_CARD: ${response.body}');

    logger.i('REQUEST_DELETE_CARD_OK: $id');

    return;
  }

}