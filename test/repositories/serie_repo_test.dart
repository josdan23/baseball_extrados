

import 'package:baseball_cards/models/serie.dart';
import 'package:baseball_cards/repositories/serie_repo.dart';
import 'package:baseball_cards/services/firebase/serie_firebase_services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final SerieRepo repo = SerieRepo.getInstance(SerieFirebaseService());

  test('Obtener todos las series del repo', () async {
    
      final lista = await repo.getAllSeries();

      print(lista);

  });


  test('Obtener una serie del repo', () async {

    final serie = await repo.getSerieById('-MubuoqoCPj8Aex3oGn5');

    print(serie);

  });

  test('Guardar nueva serie en el repo ', () async {

    final serie = Serie(description: 'Serie X', publicationDate: DateTime.now());

    final response = await repo.save(serie);

    print(response);

  });

  test('Borrar seríe del repo ', () async  {
    
    final respo = await repo.delete('1');

    print(respo);
  });

  test('Actualizar serie del repo', () async {

    final serie = Serie (description: 'actualizado', publicationDate: DateTime.now());

    final respo = await repo.update('0', serie);

    print(respo);

  });
}