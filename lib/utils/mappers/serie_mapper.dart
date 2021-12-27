
import 'package:baseball_cards/models/serie.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';

class SerieMapper extends BaseMapper<Serie> {
  
  @override
  Serie fromMap(Map<String, dynamic> json) {
    
    final Serie serie;

    try {
      serie = Serie(
        idSerie: json['id'],
        description: json["description"] ?? (throw Exception(throw Exception('La key: "description" no se encuetra en el json'))),
        publicationDate: DateTime.parse( json["publicationDate"] ?? (throw Exception('La key: "publicationDate" no se encuetra en el json')))
      );
    } catch (e) {
      print(e);
      throw Exception('Error al parsear JSON a objteo SERIE');
    }

    return serie;
  }


  @override
  Map<String, dynamic> toMap(Serie serie) {
    
    return {
        "description": serie.description,
        "idSerie": serie.idSerie,
        "publicationDate": serie.publicationDate.toString(),
    };


  }

  
}