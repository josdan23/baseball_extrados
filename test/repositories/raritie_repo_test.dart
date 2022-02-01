import 'package:baseball_cards/models/rarities.dart';
import 'package:baseball_cards/data/repositories/raritie_repo.dart';
import 'package:baseball_cards/services/firebase/rarities_firebase_services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Obtener todos las rarezas del repositorio', () async {

    final repo = RaritieRepo.getInstance( RaritiesFirebaseServices() );

    final lista = await repo.getAllRarities();

    lista.forEach(print);

  });


  test('Conseguir una rareza por id ...', () async {

    final repo = RaritieRepo.getInstance( RaritiesFirebaseServices() );


    final rarity = await repo.getRaritieById('-MuGY5N08Q2XeffCjeDT');

    print(rarity);

  });

   test('Guardar nueva rareza ...', () async {

    final repo = RaritieRepo.getInstance( RaritiesFirebaseServices() );

    final rarityToSave = Rarities(description: 'esta es una description nueva');

    final rarity = await repo.save(rarityToSave);

    print(rarity);

  });

  test('Borrar rareza ' ,() async {

    final repo = RaritieRepo.getInstance( RaritiesFirebaseServices() );

    repo.delete(' id ');

  });

 test('Actualizar rareza ' ,() async {

    final rarityToUpdate = Rarities(description: 'Platino');

    final repo = RaritieRepo.getInstance( RaritiesFirebaseServices() );

    await repo.getAllRarities();
    final rarity = await repo.update('-MuIaYzX7yeQtdvjs_wK', rarityToUpdate);

    print(rarity);

  });


}