import 'package:baseball_cards/models/player.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';
import 'package:baseball_cards/utils/mappers/player_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {


  final BaseMapper playerMapper = PlayerMapper();


  test('REGRESAR_PLAYER_CUANDO_JSON_ES_VALIDO', () async {
    
    Map<String, dynamic> map = {
      'id'        : 'AJD234',
      'firstName' : 'Daniel',
      'lastName'  : 'Yapura'
    };

    final player = playerMapper.fromMap(map);

    print(player);
  
    assert(player != null ); 
    assert(player.firstName != null);
    assert(player.lastName != null);

  });


  test('LANZAR_EXCEPCIÓN_CUANDO_JSON_NO_ES_VALIDO', () async {

    Map<String, dynamic> map = {
      'primerNombre' : 'Danie',
      'segundoNombre'  : 'Yapura'
    };
    
    expect( 
      () => playerMapper.fromMap(map), 
      throwsA(isA<Exception>())
    );

  });

  test('REGRESA_MAP_VALIDO_PASANDO_PLAYER_VALIDO', () {

    final Player player = Player(
      idPlayer: 'IDE032',
      firstName: 'Boby',
      lastName: 'Fisher'
    );

    final mapActual = playerMapper.toMap( player );

    final Map<String, dynamic> mapExpected = {
      'idPlayer': 'IDE032',
      'firstName': 'Boby',
      'lastName': 'Fisher'
    };

    print(mapActual.toString());

    mapExpected.forEach((key, value) {
      print('$key => $value = ${mapActual[key]}' );

      assert( value == mapActual[key]);
    });

  });

}