
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import 'package:baseball_cards/services/mappers/user_mapper.dart';
import 'package:baseball_cards/services/config/server.dart';
import 'package:baseball_cards/services/users_api.dart';
import 'package:baseball_cards/models/user.dart';

class UserFirebaseService extends UserApi {

  final Logger _logger = Logger();

  @override
  Future delete(String id) async {
    
    final url = Uri.https( URL_SERVER, 'users/$id.json' );

    final response = await http.delete( url );

    if (response.statusCode != 200 ){ 
      _logger.e('No se pudo borrar el usuario de la api');
      throw Exception('Error delete server');
    }

    _logger.d('RESPONSE_API_USUARIOS_DELETE: ${response.body}');

    return;

  }

  @override
  Future<Map<String, dynamic>> getAll() async {

    final url = Uri.https( URL_SERVER, 'users.json');

    final response = await http.get( url );

    if ( response.statusCode != 200 ) {
      _logger.w( 'No se obtuvo la lista de usuarios desde la api' );
      throw Exception('Error server');
    }

    _logger.d( 'RESPONSE_API_USUARIOS_GETALL: ${response.body}' );

    return json.decode(response.body);
  }

  @override
  Future<Map<String, dynamic>> getById(String id) async {
    final url = Uri.https( URL_SERVER, 'users/$id.json');

    final response = await http.get( url );

    if ( response.statusCode != 200 ) {
      _logger.e( 'No se obtuvo el usuaurio por id desde la api');
      throw Exception('Server error');
    }

    _logger.d('RESPONSE_API_USUARIO_GETBYID: ${response.body}');


    return json.decode(response.body );
  }

  @override
  Future save(User t) async {
    final url = Uri.https( URL_SERVER, 'users.json' );

    final response = await http.post(
      url,
      body: UserMapper().toJson( t )
    );

    if ( response.statusCode != 200 && response.statusCode != 201 ) {
      _logger.e('No se puedo crear el usuario en la api');
      throw Exception( 'Server error' );
    }

    _logger.d('RESPONSE_API_USUARIO_SAVE: ${ response.body }' );

    return json.decode( response.body );
  }

  @override
  Future update(String id, User t) async {
    
    final url = Uri.https( URL_SERVER, 'players/$id.json');

    final user = User(
      mail: t.mail,
      password: t.password, 
      username: t.username
    );

    user.isActive = t.isActive;
    user.role = t.role;

    //todo: agregar colección de cartas

    final response = await http.patch( 
      url,
      body: UserMapper().toJson( user ) );

    if ( response.statusCode != 200 ) {
      _logger.e('No se pudo actualizar Usuario en la api');
      throw Exception('Server error');
    } 

    _logger.d('RESPONSE_API_USUARIO_UPDATE: ${response.body}');

    return json.decode( response.body);

  } 


}