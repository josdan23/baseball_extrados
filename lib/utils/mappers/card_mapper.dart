
import 'package:baseball_cards/models/card.dart';
import 'package:baseball_cards/models/collection_card.dart';
import 'package:baseball_cards/models/player.dart';
import 'package:baseball_cards/models/rarities.dart';
import 'package:baseball_cards/models/role_player.dart';
import 'package:baseball_cards/models/serie.dart';
import 'package:baseball_cards/models/team.dart';
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

    final Card card; 
    List<CollectionCard> collectionList = [];

    try {
      card = Card(
      // collection: CollectionCardMapper().fromMap(json["collection"]),
        collection: [],
        image: json["imagen"],
        player: PlayerMapper().fromMap(json["player"]),
        rarities: RaritiesMapper().fromMap(json["raritie"]),
        rolPlayer: RolePlayerMapper().fromMap(json["role"]),
        serie: SerieMapper().fromMap(json["serie"]),
        team: TeamMapper().fromMap(json["team"]),
      );
    } catch (e) {
      print(e);
      throw Exception('Error al parsear JSON al objeto CARD');
    }

    return card;
  }



  List<Card> fromMapToList( Map<String, dynamic> json) {

    final List<Card> cards = [];
  

    json.forEach((key, value) {

      late Serie serie;
      late Player player;
      late Rarities rarities;
      late Team team;
      late RolePlayer rolePlayer;
      late CollectionCard collectionCard;
      String imagen = '';

      final mapTemp = value as Map<String, dynamic>;

      mapTemp.forEach((key, value1) {
        
        if (key == 'serie')
          serie = SerieMapper().fromMap(value1);

        if (key == 'player')
          player = PlayerMapper().fromMap(value1);

        if (key == 'raritie')
          rarities = RaritiesMapper().fromMap(value1);

        if (key == 'team')
          team = TeamMapper().fromMap(value1);

        if (key == 'role')
          rolePlayer = RolePlayerMapper().fromMap(value1);

        if (key == 'collection') 
          collectionCard = CollectionCardMapper().fromMap(value1);

        if (key == 'imagen')
          imagen = value1; 

      });

      Card cardTemp = Card(
        serie: serie, 
        player: player, 
        rarities: rarities, 
        team: team, 
        rolPlayer: rolePlayer, 
        collection: [collectionCard],
        image: imagen
      );


      cards.add(cardTemp);
    });

    return cards;

  }
  
}