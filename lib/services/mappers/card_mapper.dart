import 'package:logger/logger.dart';

import 'package:baseball_cards/models/card.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';
import 'package:baseball_cards/utils/mappers/collection_card_mapper.dart';
import 'package:baseball_cards/utils/mappers/player_mapper.dart';
import 'package:baseball_cards/utils/mappers/rarities_mapper.dart';
import 'package:baseball_cards/utils/mappers/role_player_mapper.dart';
import 'package:baseball_cards/utils/mappers/serie_mapper.dart';
import 'package:baseball_cards/utils/mappers/team_mapper.dart';

class CardMapper extends BaseMapper<Card> {

  final Logger logger = Logger();

  @override
  Card fromMap(Map<String, dynamic> json) {

    try {
    
      final list = (json['collection'] as List).map((e) => CollectionCardMapper().fromMap(e)).toList();
      
      final Card card = Card(
        idCard: json['idCard'],
        collection: list,
        image: json["imagen"],
        player: PlayerMapper().fromMap(json["player"]),
        rarities: RaritiesMapper().fromMap(json["raritie"]),
        rolPlayer: RolePlayerMapper().fromMap(json["role"]),
        serie: SerieMapper().fromMap(json["serie"]),
        team: TeamMapper().fromMap(json["team"]),
      );
    
      logger.d(card);
      return card;

    } catch (e) {

      logger.d(e);
      throw Exception('Error al parsear JSON al objeto CARD');
    
    }
  }



  List<Card> fromMapToList( Map<String, dynamic> json) {

    final List<Card> cards = [];
  
    json.forEach((key, value) {

      final Card card = CardMapper().fromMap(value);
      card.idCard = key;

      cards.add( card );

    });

    return cards;
  }



  @override
  Map<String, dynamic> toMap(Card card) {

    return {
        "collection": List.from( card.collection.map((e) => CollectionCardMapper().toMap(e)) ),
        "imagen": card.image,
        "player": PlayerMapper().toMap(card.player),
        "raritie": RaritiesMapper().toMap(card.rarities),
        "role": RolePlayerMapper().toMap(card.rolPlayer),
        "serie": SerieMapper().toMap(card.serie),
        "team": TeamMapper().toMap(card.team),
    };
  }
  
}