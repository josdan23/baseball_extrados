import 'package:baseball_cards/models/collection_card.dart';
import 'package:baseball_cards/data/repositories/collection_repo.dart';
import 'package:baseball_cards/services/firebase/collection_firebase_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final CollectionRepo repo = CollectionRepo.getInstance(CollectionFirebaseService());

  test('Obtener todas las colecciones del repositorio', () async {

    final lista = await repo.getAllCollecions();

    print(lista);

  });


  test('Obtener una coleccion del repositorio', () async  {

    final colecion = await repo.getCollectionById('-MuVwHy6X5Z0j_bYg7pX');

    print(colecion);

  });

  test('Guardar una colección en el repositorio ', () async {

    final coleccion = CollectionCard(description: 'Coleccion A');

    final response = await repo.saveNewCollection(coleccion);

    print(response);

  });

  test('Eliminar colección del repositorio', () async {

    final response = await repo.deleteCollection('-MuVwHy6X5Z0j_bYg7pX');

    print( response );

  });

  test('Actualizar coleccion del repositorio', () async {

    final newColecion = CollectionCard(description: 'colección actulizada');

    final response = await repo.updateCollection( 'id', newColecion);

    print( response );

  });
}