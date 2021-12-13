

import 'package:baseball_cards/models/collection_card.dart';
import 'package:baseball_cards/models/player.dart';
import 'package:baseball_cards/models/rarities.dart';
import 'package:baseball_cards/models/role_player.dart';
import 'package:baseball_cards/models/serie.dart';
import 'package:baseball_cards/models/team.dart';

class Card {

  final int idCard;
  final Serie serie;
  final Player player;
  final Rarities rarities;
  final Team team;
  final RolePlayer rolPlayer;
  final List<CollectionCard> collection;

  Card({
    required this.idCard, 
    required this.serie, 
    required this.player, 
    required this.rarities, 
    required this.team, 
    required this.rolPlayer, 
    required this.collection
  });

}