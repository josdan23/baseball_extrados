class Serie {
  final String? idSerie;
  final String description;
  final DateTime publicationDate;

  Serie({
    this.idSerie, 
    required this.description, 
    required this.publicationDate
  });

  @override
  String toString() {
    return 'Serie{ id: ${this.idSerie} - description: ${this.description} - publicationDate: ${this.publicationDate.toString()}}';
  }
}