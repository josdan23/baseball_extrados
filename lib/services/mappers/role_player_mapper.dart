
import 'package:baseball_cards/models/role_player.dart';
import 'package:baseball_cards/services/mappers/base_mapper.dart';

class RolePlayerMapper extends BaseMapper<RolePlayer>{
  
  @override
  RolePlayer fromMap(Map<String, dynamic> json) {
    
    final RolePlayer role;

    try {
      role = RolePlayer(
        idRolePlayer: json['idRolePlayer']  ,
        nameRole: json['name'] ?? (throw Exception('Key "name" no existe en el json'))
      );

    } catch (e) {
      print(e);
      throw Exception('Error al parserar json');
    }

    return role;
  }

  @override
  Map<String, dynamic> toMap(RolePlayer rolePlayer) {
    
    return {
        "idRolePlayer": rolePlayer.idRolePlayer,
        "name": rolePlayer.nameRole,
    };

  }

  


  
}