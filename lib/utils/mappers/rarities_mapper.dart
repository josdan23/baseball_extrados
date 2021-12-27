
import 'package:baseball_cards/models/rarities.dart';
import 'package:baseball_cards/utils/mappers/base_mapper.dart';

class RaritiesMapper implements BaseMapper<Rarities> {


  @override
  Rarities fromMap(Map<String, dynamic> json) {
    
    final Rarities raritie;

    try {
      raritie = Rarities(
        idRarities: json['id'],
        description: json['description'] ?? (throw Exception('La key: "lastName" no se encuetra en el json'))
      );
    } catch (e) {
      print(e);
      throw Exception('Error al parsear el objeto');

    }

    return raritie;

  }

}