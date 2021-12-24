
class Player {

  final String? idPlayer;
  final String firstName;
  final String lastName;

  Player({
    this.idPlayer, 
    required this.firstName, 
    required this.lastName
  });

  @override
  String toString() {
    return 'id: ${ this.idPlayer } - firstName: ${this.firstName} - lastName: ${this.lastName}';
  }

}