
import 'package:baseball_cards/models/role_player.dart';
import 'package:baseball_cards/services/mappers/role_player_mapper.dart';
import 'package:baseball_cards/services/roles_pleyer_api.dart';
import 'package:logger/logger.dart';

class RolePlayerRepo {

  final List<RolePlayer> _rolePlayerList = [];
  final RolesPlayerApi _dataSource;

  final Logger _logger = Logger();

  static RolePlayerRepo? _INSTANCE;

  static RolePlayerRepo getInstance(RolesPlayerApi dataSource) {
    _INSTANCE ??= RolePlayerRepo._internal(dataSource);
    return _INSTANCE!;
  }

  RolePlayerRepo._internal( RolesPlayerApi dataSource ) : this._dataSource = dataSource;


  Future<List<RolePlayer>> getAllRoles() async {

    try {

      final Map<String, dynamic> dataJson = await _dataSource.getAll();

      final mapper = RolePlayerMapper();

      dataJson.forEach((key, value) {
        
        final RolePlayer rolePlayerMapped = mapper.fromMap( value );
        rolePlayerMapped.idRolePlayer = key;

        if ( !_rolePlayerList.contains( rolePlayerMapped ) ) {
          _rolePlayerList.add( rolePlayerMapped );
        }

      });

      return _rolePlayerList;

    } catch(e) {
      _logger.e(e);
      throw Exception('No se pudo recuperar la lista de roles');
    }

  }

  Future<RolePlayer> getRolePlayerById( String id ) async {

    for( var oneRolePlayer in _rolePlayerList) {
      if (oneRolePlayer.idRolePlayer == id) {
        return oneRolePlayer;
      }
    }

    try {

      final dataJson = await _dataSource.getById( id );

      final rolePlayerMapped = RolePlayerMapper().fromMap( dataJson );
      rolePlayerMapped.idRolePlayer = id;

      return rolePlayerMapped;

    } catch(e ) {
      _logger.e( e );
      throw Exception('No se pudo recuepar role player id de api');
    }
    

  }

  Future<RolePlayer> save( RolePlayer roleplayer ) async {
    
    try {
      
      final dataJson = await _dataSource.save( roleplayer );

      final id = dataJson['name'];

      roleplayer.idRolePlayer = id;

      _rolePlayerList.add(roleplayer);

      return roleplayer;
    
    } catch (e) {
      _logger.e( e );
      throw Exception('No se pudo guardar el role player del api');
    }

  }

  Future<bool> delete( String id ) async {
    try {

      await _dataSource.delete( id );

      _rolePlayerList.removeWhere((element) => element.idRolePlayer == id);

      return true;

    } catch (e) {
      _logger.e( e );
      throw Exception('No se pudo borrar el rol playe en el api');
    }
  
  }

  Future<RolePlayer?> update(String id, RolePlayer rolePlayer ) async {
  
    try {

      rolePlayer.idRolePlayer = null;
      final dataJson = await _dataSource.update( id , rolePlayer);
      
      final RolePlayer rolePlayerUpdated = RolePlayerMapper().fromMap(dataJson);
      rolePlayerUpdated.idRolePlayer = id;

      for (var oneRolePlayer in _rolePlayerList) {
        if (oneRolePlayer.idRolePlayer== id) {
          oneRolePlayer.nameRole = rolePlayerUpdated.nameRole;
          return oneRolePlayer;
        }
      }
    
    } catch (e) {
      _logger.e( e );
      throw Exception( 'No se pudo actualizar el role player en el api' );
    }
  }
}