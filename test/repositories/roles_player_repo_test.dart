import 'package:flutter_test/flutter_test.dart';

import 'package:baseball_cards/models/role_player.dart';
import 'package:baseball_cards/data/repositories/roles_player_repo.dart';
import 'package:baseball_cards/services/firebase/roles_player_firebase_service.dart';

void main() {
  test('obtener todos los roles ...', () async {
    
    final repo = RolePlayerRepo.getInstance( RolesPlayerFirebaseServices());

    final lista = await repo.getAllRoles();

    lista.forEach(print);

  });

  test('Conseguir una rareza por id ...', () async {

    final repo = RolePlayerRepo.getInstance( RolesPlayerFirebaseServices() );


    final rarity = await repo.getRolePlayerById('-MuNSGL10kTtcW63YO1Y');

    print(rarity);

  });

  test('Guardar nueva role  ...', () async {

    final repo = RolePlayerRepo.getInstance( RolesPlayerFirebaseServices() );

    final roleplayerToSaved = RolePlayer(nameRole: 'Nuevo role');

    final roleplayer = await repo.save(roleplayerToSaved);

    print(roleplayer);

  });

    test('Borrar role ' ,() async {

    final repo = RolePlayerRepo.getInstance( RolesPlayerFirebaseServices() );

    repo.delete('-MuORHwqCjpmCWCpBoZK');

  });


  test('Actualizar roles player ' ,() async {

    final rarityToUpdate = RolePlayer(nameRole: 'Actualizarrole');

    final repo = RolePlayerRepo.getInstance( RolesPlayerFirebaseServices() );

    await repo.getAllRoles();
    final rarity = await repo.update('-MuORHwqCjpmCWCpBoZK', rarityToUpdate);

    print(rarity);

  });




}