import 'package:baseball_cards/models/player.dart';
import 'package:baseball_cards/repositories/player_repo.dart';
import 'package:baseball_cards/services/firebase/player_firebase_services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

    final repo = PlayerRepo.getInstance(PlayerFirebaseService());

  test( 'obtener todos los players del repo', () async {

    final lista = await repo.getAllPlayers();

    print(lista);

  });

  test( 'Obtener un player del repo', () async {

    final player = await repo.getPlayerById('3');

    print(player);

  });

  test('Guardar nuevo player en el repo', () async {
    
    final player = Player(
      firstName: 'Joe', 
      lastName: 'Dimaggio'
    );

    final response = await  repo.save(player);

    print(response);

  });

  test('Borrar player del repo ', () async {

    final resp = await repo.delete('3');

    print(resp);

  });


  test( 'Actualizar player en el repo', () async {

    final playerToUpdate = Player(firstName: 'Bella', lastName: 'Sombra');

    await repo.update('2', playerToUpdate);

  });
}