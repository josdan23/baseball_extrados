
import 'package:baseball_cards/models/player.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';

class PlayerMapper implements BaseMapper<Player> {
  
  @override
  Player fromMap(Map<String, dynamic> json) {
    
    final Player player;
    
    try {
      player = Player(
        idPlayer: json['id'],
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
}