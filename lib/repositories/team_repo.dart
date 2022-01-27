

import 'package:baseball_cards/models/team.dart';
import 'package:baseball_cards/services/mappers/team_mapper.dart';
import 'package:baseball_cards/services/team_api.dart';
import 'package:logger/logger.dart';

class TeamRepo {

  final List<Team> _teamList = [];
  final TeamApi _dataSource;

  final Logger _logger = Logger();

  static TeamRepo? _INSTANCE;

  static TeamRepo getInstance(TeamApi dataSource) {

    _INSTANCE ??= TeamRepo._internal( dataSource );
    return _INSTANCE!;

  }

  TeamRepo._internal( TeamApi dataSource ) : this._dataSource = dataSource;



  Future<List<Team>> getAllTeams() async {
    try {
      final Map<String, dynamic> dataJson = await _dataSource.getAll();

      final mapper = TeamMapper();

      dataJson.forEach((key, value) {

        final Team teamMapped = mapper.fromMap( value );
        teamMapped.idTeam = key;

        if ( !_teamList.contains( teamMapped ) ) {
          _teamList.add( teamMapped );
        }

      });

      return _teamList;

    } catch ( e ){
      _logger.e( e );
      throw Exception('No se puedo recuperar la lista de team');
    }
    
  }


  Future<Team> getTeamById( String id ) async {

    for (var oneTeam in _teamList) {
      if (oneTeam.idTeam == id ){
        return oneTeam;
      }
    }

    try {

      final dataJson = await _dataSource.getById( id );

      final teamMapped = TeamMapper().fromMap( dataJson );
      teamMapped.idTeam = id;

      _teamList.add( teamMapped );
      
      return teamMapped;

    } catch( e ) {
      _logger.e( e );
      throw Exception('No se pudo recuperar team id: $id');
    }
  }


  Future<Team> save( Team newTeam ) async {

    try {
      
      final dataJson = await _dataSource.save( newTeam );

      final id = dataJson['name'];

      newTeam.idTeam = id;

      _teamList.add( newTeam );

      return newTeam;
    
    } catch (e) {
      _logger.e( e );
      throw Exception('No se pudo crear el team en la api');
    }
  }

  Future<bool> delete( String id ) async {
    
    try {

      await _dataSource.delete( id );

      _teamList.removeWhere((element) => element.idTeam == id);

      return true;

    } catch (e) {
      _logger.e( e );
      throw Exception('No se pudo borrar el team de la api');
    }
  }


  Future<Team?> update( String id, Team teamToUpdate ) async {

    try {

      teamToUpdate.idTeam = null;
      final dataJson = await _dataSource.update( id , teamToUpdate );
      
      final Team teamUpdated = TeamMapper().fromMap(dataJson);
      teamUpdated.idTeam = id;

      for (var oneTeam in _teamList) {
        if (oneTeam.idTeam == id) {
          oneTeam.teamName = teamUpdated.teamName;
          return oneTeam;
        }
      }
    
    } catch (e) {
      _logger.e( e );
      throw Exception( 'No se pudo actualizar el team en api' );
    }

  }


}