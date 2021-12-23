
import 'package:baseball_cards/models/role_player.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';

class RolePlayerMapper implements BaseMapper<RolePlayer>{
  
  @override
  RolePlayer fromMap(Map<String, dynamic> json) {
    
    return RolePlayer(
      nameRole: json['name']
    );

  }
  
}