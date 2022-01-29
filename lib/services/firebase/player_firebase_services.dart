
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import 'package:baseball_cards/services/mappers/player_mapper.dart';
import 'package:baseball_cards/services/config/server.dart';
import 'package:baseball_cards/models/player.dart';
import 'package:baseball_cards/services/player_api.dart';

class PlayerFirebaseService extends PlayerApi {
  
  final Logger _logger = Logger();
  
  @override
  Future delete(String id) async {

    final url = Uri.https( URL_SERVER, 'players/$id.json');

    final response = await http.delete( url );

    if (response.statusCode != 200 ){ 
      _logger.e('No se pudo borrar el Jugador de la api');
      throw Exception('Error delete server');
    }

    _logger.d('RESPONSE_API_PLAYER_DELETE: ${response.body}');

    return;

  }

  @override
  Future getAll() async {
    final url = Uri.https( URL_SERVER, 'players.json');

    final response = await http.get( url );

    if ( response.statusCode != 200 ) {
      _logger.w( 'No se obtuvo la lista de player desde la api' );
      throw Exception('Error server');
    }

    _logger.d( 'RESPONSE_API_PLAYERS_GETALL: ${response.body}' );

    return json.decode(response.body);
  }

  @override
  Future getById(String id) async {

    final url = Uri.https( URL_SERVER, 'players/$id.json');

    final response = await http.get( url );

    if ( response.statusCode != 200 ) {
      _logger.e( 'No se obtuvo el player por id desde la api');
      throw Exception('Server error');
    }

    _logger.d('RESPONSE_API_PLAYER_GETBYID: ${response.body}');


    return json.decode(response.body );
  }

  @override
  Future save(Player t) async {
    final url = Uri.https( URL_SERVER, 'players.json' );

    final response = await http.post(
      url,
      body: PlayerMapper().toJson( t )
    );

    if ( response.statusCode != 200 && response.statusCode != 201 ) {
      _logger.e('No se puedo crear el player en la api');
      throw Exception( 'Server error' );
    }

    _logger.d('RESPONSE_API_PLAYER_SAVE: ${ response.body }' );

    return json.decode( response.body );
  }

  @override
  Future update(String id, Player t) async {

    final url = Uri.https( URL_SERVER, 'players/$id.json');

    final player = Player(firstName: t.firstName, lastName: t.lastName);

    final response = await http.patch( 
      url,
      body: PlayerMapper().toJson( player ) );

    if ( response.statusCode != 200 ) {
      _logger.e('No se pudo actualizar Player en la api');
      throw Exception('Server error');
    } 

    _logger.d('RESPONSE_API_PLAYER_UPDATE: ${response.body}');

    return json.decode( response.body);
  }

}