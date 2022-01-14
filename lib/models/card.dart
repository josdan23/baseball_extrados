

import 'package:baseball_cards/models/collection_card.dart';
import 'package:baseball_cards/models/player.dart';
import 'package:baseball_cards/models/rarities.dart';
import 'package:baseball_cards/models/role_player.dart';
import 'package:baseball_cards/models/serie.dart';
import 'package:baseball_cards/models/team.dart';

class Card {

  String? idCard;
  final Serie serie;
  final Player player;
  final Rarities rarities;
  final Team team;
  final RolePlayer rolPlayer;
  final List<CollectionCard> collection;
  final String? image;

  Card({
    this.idCard, 
    required this.serie, 
    required this.player, 
    required this.rarities, 
    required this.team, 
    required this.rolPlayer, 
    required this.collection,
    this.image = ''
  });

  @override
  String toString() {
    final sb = StringBuffer();
    sb
      ..write('Card { idCard: ${this.idCard}\n')
      ..write('\t ${this.serie.toString()}\n')
      ..write('\t${this.player.toString()}\n')
      ..write('\t${this.rarities.toString()}\n')
      ..write('\t${this.team.toString()}\n')
      ..write('\t${this.rolPlayer.toString()}\n')
      ..write('\t${this.collection.toString()}\n')
      ..write('\t${this.image}\n')
      ..write('}');

    return sb.toString();
  }

}