
class Rarities {
  final String? idRarities;
  final String description;

  Rarities({
    this.idRarities, 
    required this.description
  });

  @override
  String toString() {
    return 'Rarities{ id: ${this.idRarities} - description: ${this.description} }';
  }
}