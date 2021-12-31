
import 'package:baseball_cards/models/rarities.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';

class RaritiesMapper extends BaseMapper<Rarities> {


  @override
  Rarities fromMap(Map<String, dynamic> json) {
    
    final Rarities raritie;

    try {
      raritie = Rarities(
        idRarities: json['idRarities'],
        description: json['description'] ?? (throw Exception('La key: "lastName" no se encuetra en el json'))
      );
    } catch (e) {
      print(e);
      throw Exception('Error al parsear el objeto');

    }

    return raritie;

  }


  @override
  Map<String, dynamic> toMap(Rarities rarities) {
    
    return {
        "description": rarities.description,
        "idRarities": rarities.idRarities,
    };

  }


}