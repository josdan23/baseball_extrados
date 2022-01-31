
import 'package:baseball_cards/models/rarities.dart';
import 'package:baseball_cards/services/mappers/base_mapper.dart';

class RaritiesMapper extends BaseMapper<Rarities> {


  @override
  Rarities fromMap(Map<String, dynamic> json) {
    
    final Rarities raritie;

    try {
      raritie = Rarities(
        idRarities: json['idRaritie'],
        description: json['description'] ?? (throw Exception('La key: "description" no se encuetra en el json'))
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
        "idRaritie": rarities.idRarities,
    };

  }


}