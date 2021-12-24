import 'package:baseball_cards/models/serie.dart';

class CollectionCard {

  final String? idCollection;
  final String description;
  // final Serie serie;

  CollectionCard({
    this.idCollection, 
    required this.description, 
    // required this.serie
  });

  @override
  String toString() {
    return 'CollectionCard{ id: ${this.idCollection} - description: ${this.description} }';
  }


}