import 'package:baseball_cards/models/rarities.dart';
import 'package:baseball_cards/services/firebase/rarities_firebase_services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Probando obtener todas las rarezas de raritie firebas services', () async {

    final RaritiesFirebaseServices api = RaritiesFirebaseServices();

    final response = await api.getAll();

    print( response );

  });


  test('Obtener una sola rareza', () async {

    final RaritiesFirebaseServices api = RaritiesFirebaseServices();

    final response = await api.getById('-MuGY5N08Q2XeffCjeDT');

    print( response );

  });

  test('Guardar rareza', () async {

    final RaritiesFirebaseServices api = RaritiesFirebaseServices();

    final Rarities rarities = Rarities(description: 'platino');

    final response = await api.save(rarities);

    print( response );

  });



  test('Actualizar rareza', () async {

    final RaritiesFirebaseServices api = RaritiesFirebaseServices();

    final Rarities rarities = Rarities(
      description: 'actualizar rareza');

    final response = await api.update( '0', rarities);

    print( response );

  });
}