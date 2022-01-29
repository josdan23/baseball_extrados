import 'dart:convert';
import 'package:baseball_cards/services/mappers/serie_mapper.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'package:baseball_cards/services/config/server.dart';
import 'package:baseball_cards/models/serie.dart';
import 'package:baseball_cards/services/series_api.dart';



class SerieFirebaseService extends SeriesApi {
  
  final Logger _logger = Logger();

  @override
  Future delete(String id) async {

    final url = Uri.https( URL_SERVER, 'series/$id.json');

    final response = await http.delete( url );

    if (response.statusCode != 200 ){ 
      _logger.e('No se pudo borrar la serie de la api');
      throw Exception('Error delete server');
    }

    _logger.d('RESPONSE_API_SERIE_DELETE: ${response.body}');

    return;

  }

  @override
  Future getAll() async {
    
    final url = Uri.https( URL_SERVER, 'series.json');

    final response = await http.get( url );

    if ( response.statusCode != 200 ) {
      _logger.w( 'No se obtuvo la lista de series desde la api' );
      throw Exception('Error server');
    }

    _logger.d( 'RESPONSE_API_SERIES_GETALL: ${response.body}' );

    return json.decode(response.body);

  }

  @override
  Future getById(String id) async {

    final url = Uri.https( URL_SERVER, 'series/$id.json');

    final response = await http.get( url );

    if ( response.statusCode != 200 ) {
      _logger.e( 'No se obtuvo el serie por id desde la api');
      throw Exception('Server error');
    }

    _logger.d('RESPONSE_API_SERIE_GETBYID: ${response.body}');


    return json.decode(response.body );
  }

  @override
  Future save(Serie t) async {

    final url = Uri.https( URL_SERVER, 'series.json' );

    final response = await http.post(
      url,
      body: SerieMapper().toJson( t )
    );

    if ( response.statusCode != 200 && response.statusCode != 201 ) {
      _logger.e('No se puedo crear el series en la api');
      throw Exception( 'Server error' );
    }

    _logger.d('RESPONSE_API_SERIE_SAVE: ${ response.body }' );

    return json.decode( response.body );
  }

  @override
  Future update(String id, Serie t) async {

    final url = Uri.https( URL_SERVER, 'series/$id.json');

    final serie = Serie(description: t.description, publicationDate: t.publicationDate);

    final response = await http.patch( 
      url,
      body: SerieMapper().toJson( serie ) );

    if ( response.statusCode != 200 ) {
      _logger.e('No se pudo actualizar Serie en la api');
      throw Exception('Server error');
    } 

    _logger.d('RESPONSE_API_SERIE_UPDATE: ${response.body}');

    return json.decode( response.body);

  }

}