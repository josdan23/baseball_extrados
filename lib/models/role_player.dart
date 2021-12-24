
class RolePlayer {
  final String? idRolePlayer;
  final String nameRole;

  RolePlayer({
    this.idRolePlayer, 
    required this.nameRole
  });

  @override
  String toString() {

    return 'RolePlayer { id: ${this.idRolePlayer} - nameRole: ${this.nameRole} }';
  }


}