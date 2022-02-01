
import 'package:logger/logger.dart';

import 'package:baseball_cards/services/mappers/player_mapper.dart';
import 'package:baseball_cards/models/player.dart';
import 'package:baseball_cards/services/player_api.dart';

class PlayerRepo {
 
  static PlayerRepo? _INSTANCE;

  final List<Player> _playerList = [];
  final PlayerApi _dataSource;

  final Logger _logger = Logger();


  static PlayerRepo getInstance( PlayerApi dataSource ) {
    _INSTANCE ??= PlayerRepo._internal( dataSource );
    return _INSTANCE!;
  }

  PlayerRepo._internal( PlayerApi dataSource ): this._dataSource = dataSource;




  Future<List<Player>> getAllPlayers() async {
    try {
      final Map<String, dynamic> dataJson = await _dataSource.getAll();

      final mapper = PlayerMapper();

      dataJson.forEach((key, value) {

        final Player playerMapped = mapper.fromMap( value );
        playerMapped.idPlayer = key;

        if ( !_playerList.contains( playerMapped ) ) {
          _playerList.add( playerMapped );
        }

      });

      return _playerList;

    } catch ( e ){
      _logger.e( e );
      throw Exception('No se puedo recuperar la lista de player del repo');
    }
    
  }


  Future<Player> getPlayerById( String id ) async {

    for (var onePlayer in _playerList) {
      if (onePlayer.idPlayer== id ){
        return onePlayer;
      }
    }

    try {

      final dataJson = await _dataSource.getById( id );

      final playerMapped = PlayerMapper().fromMap( dataJson );
      playerMapped.idPlayer = id;

      _playerList.add( playerMapped );
      
      return playerMapped;

    } catch( e ) {
      _logger.e( e );
      throw Exception('No se pudo recuperar player id: $id');
    }
  }


  Future<Player> save( Player newPlayer ) async {

    try {
      
      final dataJson = await _dataSource.save( newPlayer );

      final id = dataJson['name'];

      newPlayer.idPlayer = id;

      _playerList.add( newPlayer );

      return newPlayer;
    
    } catch (e) {
      _logger.e( e );
      throw Exception('No se pudo crear el player en la api');
    }
  }

  Future<bool> delete( String id ) async {
    
    try {

      await _dataSource.delete( id );

      _playerList.removeWhere((element) => element.idPlayer== id);

      return true;

    } catch (e) {
      _logger.e( e );
      throw Exception('No se pudo borrar el player de la api');
    }
  }


  Future<Player?> update( String id, Player playerToUpdate ) async {

    try {

      playerToUpdate.idPlayer = null;
      final dataJson = await _dataSource.update( id , playerToUpdate );
      
      final Player playerUpdated = PlayerMapper().fromMap(dataJson);
      playerUpdated.idPlayer = id;

      for (var onePlayer in _playerList) {
        if (onePlayer.idPlayer == id) {
          onePlayer.firstName = playerUpdated.firstName;
          onePlayer.lastName = playerUpdated.lastName;
          return onePlayer;
        }
      }
    
    } catch (e) {
      _logger.e( e );
      throw Exception( 'No se pudo actualizar el player en api' );
    }

  }



}