import 'package:flutter_test/flutter_test.dart';

import 'package:baseball_cards/models/role_player.dart';
import 'package:baseball_cards/services/firebase/roles_player_firebase_service.dart';
import 'package:baseball_cards/services/roles_pleyer_api.dart';

void main() {
  test('Obteniendo todos los roles...', () async  {

    final RolesPlayerApi api = RolesPlayerFirebaseServices();

    final response = await api.getAll();

    print(response);

  });

  test( 'Obtener rol por id ', () async  {

    final RolesPlayerApi api = RolesPlayerFirebaseServices();

    final response = await api.getById('20');

    print(response);

  });


  test('Guardar nuevo role', () async {

    final RolesPlayerApi api = RolesPlayerFirebaseServices();

    final RolePlayer rolePlayer = RolePlayer(nameRole: 'jardinero central');

    final response = await api.save( rolePlayer );

    print(response);

  });

  test('Actualizar role', () async {

    final RolesPlayerApi api = RolesPlayerFirebaseServices();

    final response = await api.update('5', RolePlayer(nameRole: 'actualizado'));

    print(response);

  });
  
}