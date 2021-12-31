
import 'package:baseball_cards/models/player.dart';
import 'package:baseball_cards/services/mappers/base_mapper.dart';

class PlayerMapper extends BaseMapper<Player> {
  
  @override
  Player fromMap(Map<String, dynamic> json) {
    
    final Player player;
    
    try {
      player = Player(
        idPlayer: json['idPlayer'],
        firstName: json['firstName'] ?? (throw Exception('La key: "firstName" no se encuetra en el json ')), 
        lastName: json['lastName'] ?? (throw Exception('La key: "lastName" no se encuetra en el json')),
      );
    }
    catch(e) {
      print(e);
      throw Exception('Error al parsear el objeto');
    }

    return player;
  }

  @override
  Map<String, dynamic> toMap(Player player) {
    
    return {
        "firstName": player.firstName,
        "idPlayer": player.idPlayer,
        "lastName": player.lastName,
    };

  }
}