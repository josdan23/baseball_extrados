import 'package:baseball_cards/models/team.dart';
import 'package:baseball_cards/services/firebase/team_firebase_service.dart';
import 'package:baseball_cards/services/team_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('Obtener todos los teams ...', () async {

    final TeamApi api = TeamFirebaseService();

    final response = await api.getAll();

    print(response);
    
  });

  test(' Obtener team por id', () async  {
    
    final TeamApi api = TeamFirebaseService();

    final response = await api.getById('3');

    print(response);  
  });

  test( 'Guardar nuevo team', () async {
    
    final TeamApi api = TeamFirebaseService();

    final Team team = Team(teamName: 'Atlanta Braves');

    final response = await api.save(team);

    print(response);

  });


  test('Actualizar team', () async {

    final TeamApi api = TeamFirebaseService();

    final response = await api.update('5', Team(teamName: 'equipo actualizado'));

    print(response);

  });

  test('eliminar team', () async {

    final TeamApi api = TeamFirebaseService();

    final response = await api.delete('-MuQtdYOsvQDXi-_Yqkj');

    print(response);

  });
}