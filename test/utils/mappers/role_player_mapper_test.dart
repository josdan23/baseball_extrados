import 'package:baseball_cards/services/mappers/base_mapper.dart';
import 'package:baseball_cards/services/mappers/role_player_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    
  final BaseMapper rolePlayerMapper = RolePlayerMapper();

  test('REGRESAR_ROLEPLAYER_CUANDO_JSON_ES_VALIDO', () async {
    
    Map<String, dynamic> map = {
      'id'        : 'AJD234',
      'name' : 'Role admin',
    };

    final rolPlayer = rolePlayerMapper.fromMap(map);
    print(rolPlayer.toString());

    assert(rolPlayer != null );
  });


  test('LANZAR_EXCEPCION_CUANDO_UNA_KEY_DEL_JSON_NO_SE_ENCUENTRA', () async {

    Map<String, dynamic> map = {
      'id' : 'Danie',
      'NombreRole'  : 'Yapura'
    };
    
    expect( 
      () => rolePlayerMapper.fromMap(map), 
      throwsA(isA<Exception>())
    );

  });

}