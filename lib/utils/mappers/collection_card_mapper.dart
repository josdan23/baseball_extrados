
import 'package:baseball_cards/models/collection_card.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';

class CollectionCardMapper implements BaseMapper<CollectionCard> {
  
  
  @override
  CollectionCard fromMap(Map<String, dynamic> json) {

    final CollectionCard collectionCard;

    try {
      collectionCard = CollectionCard(
        idCollection  : json['id'],
        description   : json['description'] ?? (throw Exception('La key: "description" no se encuetra en el json'))
      );

    } catch (e) {
      print(e);
      throw Exception('Error al parsear JSON a objeto CollectionCard');

    }

    return collectionCard;
  }

}