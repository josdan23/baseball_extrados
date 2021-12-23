
import 'package:baseball_cards/models/player.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';

class PlayerMapper implements BaseMapper<Player> {
  
  @override
  Player fromMap(Map<String, dynamic> json) {
    
    return Player(
      firstName: json['fistName'], 
      lastName: json['lastName'],
    );

  }

}