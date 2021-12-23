
import 'package:baseball_cards/models/collection_card.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';

class CollectionCardMapper implements BaseMapper<CollectionCard> {
  
  
  @override
  CollectionCard fromMap(Map<String, dynamic> json) {

    return CollectionCard(
      description: json['description']
    );


  }

}