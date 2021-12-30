

import 'package:baseball_cards/models/team.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';

class TeamMapper extends BaseMapper<Team> {
  
  @override
  Team fromMap(Map<String, dynamic> json) {

    final Team team;

    try {
      team = Team(
        idTeam: json['idTeam'],
        teamName: json['name'] ?? (throw Exception('La key: "teamName" no se encuetra en el json'))
      );
    } catch (e) {
      print(e);
      throw Exception('Error al parsear JSON a objeto TEAM');
    }

    return team;
  }


  @override
  Map<String, dynamic> toMap(Team team) {

    return {
        "idTeam": team.idTeam,
        "name": team.teamName,
    };
  }


}