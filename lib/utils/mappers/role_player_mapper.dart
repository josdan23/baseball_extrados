
import 'package:baseball_cards/models/role_player.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';

class RolePlayerMapper implements BaseMapper<RolePlayer>{
  
  @override
  RolePlayer fromMap(Map<String, dynamic> json) {
    
    final RolePlayer role;

    try {
      role = RolePlayer(
        idRolePlayer: json['id']  ,
        nameRole: json['name'] ?? (throw Exception('Key "name" no existe en el json'))
      );

    } catch (e) {
      print(e);
      throw Exception('Error al parserar json');
    }

    return role;
  }
  
}