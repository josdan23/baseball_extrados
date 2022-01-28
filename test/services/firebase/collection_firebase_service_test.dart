import 'package:baseball_cards/models/collection_card.dart';
import 'package:baseball_cards/services/collection_api.dart';
import 'package:baseball_cards/services/firebase/collection_firebase_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final CollectionApi api = CollectionFirebaseService();

  test('Listar todas las colecciones en la api', () async {
  
    final response = await api.getAll();

    print(response);

  });

  test('Obtener una colección de la api', () async  {

    final response = await api.getById('3');

    print(response);

  });

  test('Guardar nueva colección en la api', () async  {

    final CollectionCard newCollection = CollectionCard(description: 'Esta es una colección');

    final response = await api.save(newCollection);

    print(response);

  });

  test('Eliminar la coleción en la api', () async {

    final response = await api.delete('2');

    print(response);

  });

  test('Actualizar colección en la api', () async {

    final colectionToUpdated = CollectionCard(description: 'Actualizado');

    final response = await api.update('0', colectionToUpdated);

    print(response);

  });
}