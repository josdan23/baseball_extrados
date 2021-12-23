
import 'package:baseball_cards/models/rarities.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';

class RaritiesMapper implements BaseMapper<Rarities> {


  @override
  Rarities fromMap(Map<String, dynamic> json) {
    
    return Rarities(
      description: json['description']
    );
    
  }

}