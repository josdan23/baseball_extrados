

class Team {

  final String? idTeam;
  final String teamName;

  Team({
    this.idTeam, 
    required this.teamName
  });

  @override
  String toString() {
    return 'Team { id: ${this.idTeam} - teanName: ${this.teamName}}';
  }

}