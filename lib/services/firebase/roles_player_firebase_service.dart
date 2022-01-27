
import 'dart:convert';
import 'package:baseball_cards/services/mappers/role_player_mapper.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import 'package:baseball_cards/services/config/server.dart';
import 'package:baseball_cards/models/role_player.dart';
import 'package:baseball_cards/services/roles_pleyer_api.dart';

class RolesPlayerFirebaseServices extends RolesPlayerApi {

  final Logger _logger = Logger();

  @override
  Future delete(String id) async {

    final url = Uri.https( URL_SERVER, 'roles/$id.json' );

    final response = await http.delete( url );

    if ( response.statusCode != 200 ) {
      _logger.e('No se puedo borrar el role en la api' );
      throw Exception( 'Server error' );
    }

    _logger.d( 'RESPONSE_API_ROLESPLAYER_DELETE: ${response.body}');

    return;
  }

  @override
  Future getAll() async {

    final url = Uri.https( URL_SERVER, 'roles.json');

    final response = await http.get( url );

    if ( response.statusCode != 200 ) {
      _logger.w( 'No se obtuvo la lista de roles player desde la api' );
      throw Exception('Error server');
    }

    _logger.d( 'RESPONSE_API_ROLES_PLAYER_GETALL: ${response.body}' );

    return json.decode(response.body);

  }

  @override
  Future getById(String id) async {

    final url = Uri.https( URL_SERVER, 'roles/$id.json');

    final response = await http.get( url );

    if ( response.statusCode != 200 ) {
      _logger.e( 'No se obtuvo el rol por id desde la api');
      throw Exception('Server error');
    }

    _logger.d('RESPONSE_API_ROLES_PLAYER_GETBYID: ${response.body}');


    return json.decode(response.body );
  }

  @override
  Future save(RolePlayer t) async {

    final url = Uri.https( URL_SERVER, 'roles.json' );

    final response = await http.post(
      url,
      body: RolePlayerMapper().toJson( t )
    );

    if ( response.statusCode != 200 && response.statusCode != 201 ) {
      _logger.e('No se puedo crear el role en la api');
      throw Exception( 'Server error' );
    }

    _logger.d('RESPONSE_API_ROLE_PLAYER_SAVE: ${ response.body }' );

    return json.decode( response.body );

  }

  @override
  Future update(String id, RolePlayer t) async {

    final url = Uri.https( URL_SERVER, 'roles/$id.json');

    final role = RolePlayer(nameRole: t.nameRole);

    final response = await http.patch( 
      url,
      body: RolePlayerMapper().toJson( role ) );

    if ( response.statusCode != 200 ) {
      _logger.e('No se pudo actualizar Role en la api');
      throw Exception('Server error');
    } 

    _logger.d('RESPONSE_API_ROLEPLAYER_UPDATE: ${response.body}');

    return json.decode( response.body);
  }

}