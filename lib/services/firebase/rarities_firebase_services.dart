
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'package:baseball_cards/services/mappers/rarities_mapper.dart';
import 'package:baseball_cards/services/config/server.dart';
import 'package:baseball_cards/models/rarities.dart';
import 'package:baseball_cards/services/raririties_api.dart';

class RaritiesFirebaseServices extends RaritiesApi {

  final Logger logger = Logger();

  @override
  Future<Map<String,dynamic>> getAll() async {
    
    final url = Uri.https( URL_SERVER, 'rarities.json' );

    final response = await http.get( url ); 

    if ( response.statusCode != 200 ) {
      throw Exception('Error server');
    }

    return json.decode(response.body);
  }


  @override
  Future<Map< String, dynamic> >getById(String id) async {
    
    final url = Uri.https( URL_SERVER, 'rarities/$id.json');

    final response = await http.get( url );

    if ( response.statusCode != 200 ){
      throw Exception( 'Server error' );
    }

    logger.d('Respuesta de api de rarezas: ${response.body}');

    return json.decode(response.body);

  }

  @override
  Future<Map<String, dynamic>> save(Rarities t) async {
   
    final url = Uri.https( URL_SERVER, 'rarities.json');

    final response = await http.post(
      url,
      body: RaritiesMapper().toJson( t ) 
    );

    if ( response.statusCode != 200 && response.statusCode != 201 ) {
      throw Exception('Serve error');
    } 

    logger.d('Respuesta de api para guardar rareza: ${response.body}');

    return json.decode( response.body );

  }


  @override
  Future delete(String id) async {

    final url = Uri.https( URL_SERVER, 'rarities/$id.json' );

    final response = await http.delete( url  );

    if ( response.statusCode != 200 ){
      throw Exception('Server error');
    }

    return;
  }

  

  @override
  Future< Map<String, dynamic> > update(String id, Rarities t) async {
    
    final url = Uri.https( URL_SERVER, 'rarities/$id.json' );

    //TODO: borrar el id de la rareza
    final rarities = Rarities(description: t.description);

    final response = await http.patch(
      url,
      body: RaritiesMapper().toJson( rarities)
    );

    if ( response.statusCode != 200 ) {
      throw Exception('Server error');
    }

    logger.d('Respuesta de api al actualizar rareza: ${response.body}' );
  
    return json.decode( response.body );
  }

}