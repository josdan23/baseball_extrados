
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'package:baseball_cards/models/collection_card.dart';
import 'package:baseball_cards/services/mappers/collection_card_mapper.dart';
import 'package:baseball_cards/services/collection_api.dart';
import 'package:baseball_cards/services/config/server.dart';

class CollectionFirebaseService extends CollectionApi {
  
  final Logger _logger = Logger();

  @override
  Future delete(String id) async {

    final url = Uri.https( URL_SERVER, 'collections/$id.json');

    final response = await http.delete( url );

    if ( response.statusCode != 200 ) {
      _logger.e('No se puedo borrar la colección del api' );
      throw Exception( 'Server error' );
    }

    _logger.d( 'RESPONSE_API_COLLECTION_DELETE: ${response.body}');

    return json.decode(response.body);

  }


  @override
  Future getAll() async {

    final url = Uri.https( URL_SERVER, 'collections.json');

    final response = await http.get( url );

    if ( response.statusCode != 200 ) {
      _logger.w( 'No se obtuvo la lista de colecciones desde la api' );
      throw Exception('Error server');
    }

    _logger.d( 'RESPONSE_API_COLLECTIONS_GETALL: ${response.body}' );

    return json.decode(response.body);
  }

  @override
  Future getById(String id) async {

    final url = Uri.https( URL_SERVER, 'collections/$id.json');

    final response = await http.get( url );

    if ( response.statusCode != 200 ) {
      _logger.e( 'No se obtuvo la colección por id desde la api');
      throw Exception('Server error');
    }

    _logger.d('RESPONSE_API_COLLECTIONS_GETBYID: ${response.body}');


    return json.decode(response.body );
    
  }

  @override
  Future<Map<String,dynamic>> save(CollectionCard t) async {
    final url = Uri.https( URL_SERVER, 'collections.json' );

    final response = await http.post(
      url,
      body: CollectionCardMapper().toJson( t )
    );

    if ( response.statusCode != 200 && response.statusCode != 201 ) {
      _logger.e('No se puedo crear la coleción en la api');
      throw Exception( 'Server error' );
    }

    _logger.d('RESPONSE_API_COLLECTION_SAVE: ${ response.body }' );

    return json.decode( response.body );
  }

  @override
  Future update(String id, CollectionCard t) async {

    final url = Uri.https( URL_SERVER, 'collections/$id.json');

    final collection = CollectionCard(description: t.description);

    final response = await http.patch( 
      url,
      body: CollectionCardMapper().toJson( collection ) );

    if ( response.statusCode != 200 ) {
      _logger.e('No se pudo actualizar colección en la api');
      throw Exception('Server error');
    } 

    _logger.d('RESPONSE_API_COLLECTION_UPDATE: ${response.body}');

    return json.decode( response.body);
  }

}