
import 'package:baseball_cards/models/serie.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';

class SerieMapper implements BaseMapper<Serie> {
  
  @override
  Serie fromMap(Map<String, dynamic> json) {
    
    return Serie( 
      description: json["description"],
      publicationDate: DateTime.parse( json["publicationDate"]),
    );
  }

}