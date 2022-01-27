import 'package:baseball_cards/models/team.dart';
import 'package:baseball_cards/repositories/team_repo.dart';
import 'package:baseball_cards/services/firebase/team_firebase_service.dart';
import 'package:baseball_cards/services/team_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final TeamRepo repo = TeamRepo.getInstance(TeamFirebaseService());;

  test('Obtener todos los equipos', () async {

    final lista  = await repo.getAllTeams();

    print(lista);

  });

  test( 'Conseguir team por id', () async {

    final team = await repo.getTeamById('-MuRznACvnZ-5Nzg9VQ-');

    print(team);

  });

  test('Guardar nuevo team', () async {

    final nuevoTeam = await repo.save(Team(teamName: 'Nuevo equipo'));

    print(nuevoTeam);

  });

  test( 'borrar team del repo ', () async {

    final borrado = await repo.delete('-MuSuI7wjoEsz5LF_1CM');

    print(borrado);

  });
}