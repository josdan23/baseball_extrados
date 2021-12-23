
import 'package:baseball_cards/models/card.dart';
import 'package:baseball_cards/models/collection_card.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';
import 'package:baseball_cards/utils/mappers/collection_card_mapper.dart';
import 'package:baseball_cards/utils/mappers/player_mapper.dart';
import 'package:baseball_cards/utils/mappers/rarities_mapper.dart';
import 'package:baseball_cards/utils/mappers/role_player_mapper.dart';
import 'package:baseball_cards/utils/mappers/serie_mapper.dart';
import 'package:baseball_cards/utils/mappers/team_mapper.dart';

class CardMapper implements BaseMapper<Card> {


  @override
  Card fromMap(Map<String, dynamic> json) {

    List<CollectionCard> collectionList = [];


    return Card(
      // collection: CollectionCardMapper().fromMap(json["collection"]),
      collection: [],
      image: json["imagen"],
      player: PlayerMapper().fromMap(json["player"]),
      rarities: RaritiesMapper().fromMap(json["raritie"]),
      rolPlayer: RolePlayerMapper().fromMap(json["role"]),
      serie: SerieMapper().fromMap(json["serie"]),
      team: TeamMapper().fromMap(json["team"]),
    );

  }
  
}