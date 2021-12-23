

import 'package:baseball_cards/models/team.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';

class TeamMapper extends BaseMapper<Team> {
  
  @override
  Team fromMap(Map<String, dynamic> json) {
    return Team(
      teamName: json['name'] 
    );
  }


}