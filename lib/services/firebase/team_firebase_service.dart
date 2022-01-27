import 'dart:convert';
import 'package:baseball_cards/services/mappers/team_mapper.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import 'package:baseball_cards/services/config/server.dart';
import 'package:baseball_cards/models/team.dart';
import 'package:baseball_cards/services/team_api.dart';

class TeamFirebaseService extends TeamApi {

  final Logger _logger = Logger();

  @override
  Future delete(String id) async {

    final url = Uri.https( URL_SERVER, 'teams/$id.json' );

    final response = await http.delete( url );

    if ( response.statusCode != 200 ) {
      _logger.e('No se puedo borrar el team en la api' );
      throw Exception( 'Server error' );
    }

    _logger.d( 'RESPONSE_API_TEAM_DELETE: ${response.body}');

    return;
  }

  @override
  Future getAll() async {

    final url = Uri.https( URL_SERVER, 'teams.json');

    final response = await http.get( url );

    if ( response.statusCode != 200 ) {
      _logger.w( 'No se obtuvo la lista de teams desde la api' );
      throw Exception('Error server');
    }

    _logger.d( 'RESPONSE_API_TEAM_GETALL: ${response.body}' );

    return json.decode(response.body);

  }

  @override
  Future getById(String id) async {

    final url = Uri.https( URL_SERVER, 'teams/$id.json');

    final response = await http.get( url );

    if ( response.statusCode != 200 ) {
      _logger.e( 'No se obtuvo el team por id desde la api');
      throw Exception('Server error');
    }

    _logger.d('RESPONSE_API_TEAM_GETBYID: ${response.body}');


    return json.decode(response.body );
  }

  @override
  Future save(Team t) async {

    final url = Uri.https( URL_SERVER, 'teams.json' );

    final response = await http.post(
      url,
      body: TeamMapper().toJson( t )
    );

    if ( response.statusCode != 200 && response.statusCode != 201 ) {
      _logger.e('No se puedo crear el team en la api');
      throw Exception( 'Server error' );
    }

    _logger.d('RESPONSE_API_TEAM_SAVE: ${ response.body }' );

    return json.decode( response.body );

  }

  @override
  Future update(String id, Team t) async {

    final url = Uri.https( URL_SERVER, 'teams/$id.json');

    final team = Team(teamName: t.teamName);

    final response = await http.patch( 
      url,
      body: TeamMapper().toJson( team ) );

    if ( response.statusCode != 200 ) {
      _logger.e('No se pudo actualizar Team en la api');
      throw Exception('Server error');
    } 

    _logger.d('RESPONSE_API_TEAM_UPDATE: ${response.body}');

    return json.decode( response.body);
  }


}