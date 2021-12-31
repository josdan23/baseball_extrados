
import 'package:baseball_cards/models/collection_card.dart';
import 'package:baseball_cards/services/mappers/base_mapper.dart';

class CollectionCardMapper extends BaseMapper<CollectionCard> {
  
  
  @override
  CollectionCard fromMap(Map<String, dynamic> json) {

    final CollectionCard collectionCard;

    try {
      collectionCard = CollectionCard(
        idCollection  : json['idCollection'],
        description   : json['description'] ?? (throw Exception('La key: "description" no se encuetra en el json'))
      );

    } catch (e) {
      print(e);
      throw Exception('Error al parsear JSON a objeto CollectionCard');

    }

    return collectionCard;
  }

  @override
  Map<String, dynamic> toMap(CollectionCard collectionCard) {

    return {
        "description": collectionCard.description,
        "idCollection": collectionCard.idCollection,
    };

  }

}