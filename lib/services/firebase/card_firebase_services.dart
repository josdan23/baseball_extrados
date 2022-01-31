
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'package:baseball_cards/services/mappers/card_mapper.dart';
import 'package:baseball_cards/services/config/server.dart';
import 'package:baseball_cards/models/card.dart' ;
import 'package:baseball_cards/services/cards_api.dart';

class CardFirebaseServices extends CardsApi {

  final Logger _logger = Logger();


  @override
  Future<Map<String, dynamic>> getAll() async {

    final url = Uri.https( URL_SERVER, 'cards.json');
    final response = await http.get( url );
  

    if (response.statusCode != 200) {
      _logger.e('No se pudo recuperar las cartas del servidor');
      throw Exception('No se pudo recuperar todas las cartas del servidor');
    }

    _logger.i( 'RESPONSE_API_CARDS_GET_ALL = ${response.body}');
    return json.decode( response.body );
    
  }
  

  @override
  Future<Map<String, dynamic>> getById(String id) async {
    
    final url = Uri.https( URL_SERVER, 'cards/$id.json' );
    final response = await http.get(url);

    if (response.statusCode != 200) {
      _logger.e('No se pudo recuperar una carta del servidor' );
      throw Exception(' No se pudo recuperar una carta del servidor' );
    }

    _logger.i( 'RESPONSE_API_CARDS_GET_By_Id = ${response.body}');    
    return json.decode( response.body );

  }


  @override
  Future<Map<String, dynamic>> save(Card card) async {

    final url = Uri.https( URL_SERVER, 'cards.json');
    final response = await http.post( 
      url, 
      body: CardMapper().toJson(card)
    );

    if( response.statusCode != 200 && response.statusCode != 201 ){
      _logger.e('No se pudo guardar la carta en el servidor');
      throw Exception('No se pudo guardar la carta en el servidor' );
    }

    _logger.i('RESPONSE_API_CARDS_SAVE');
    return json.decode( response.body );
  }


  @override
  Future<Map<String, dynamic>> update( String cardId, Card card) async {
    
    final url = Uri.https( URL_SERVER, 'cards/$cardId.json');
    final response = await http.patch( 
      url, 
      body: CardMapper().toJson( card ) 
    );

    if( response.statusCode != 200 ) {
      _logger.e( 'No se pudo actualizar la carta en el servidor' );
      throw Exception( 'No se pudo actualizar la carta en el servidor' );
    }

    return json.decode( response.body );
  }


  @override
  Future delete(String id) async {
    
    final url = Uri.https( URL_SERVER, 'cards/$id.json');
    final response = await http.delete( url );

    if( response.statusCode != 200 ){
      _logger.e( 'No se pudo borrar la carta en el servidor.' );
      throw Exception( 'No se pudo borrar la carta en el servidor.' );
    }

    return json.decode( response.body );

  }

}