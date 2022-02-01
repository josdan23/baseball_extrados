
import 'package:baseball_cards/models/user.dart';
import 'package:baseball_cards/services/mappers/user_mapper.dart';
import 'package:baseball_cards/services/users_api.dart';
import 'package:logger/logger.dart';

class UserRepo {

  final List<User> _userList = [];

  final UserApi _dataSource;

  final Logger _logger = Logger();

  static UserRepo? _INSTANCE;

  static UserRepo getInstance( UserApi dataSource ) {

    _INSTANCE ??= UserRepo._internal( dataSource );
    return _INSTANCE!;

  }

  UserRepo._internal( UserApi dataSource ) : this._dataSource = dataSource;


  Future<List<User>> getAllUsers() async {

    try {

      final Map<String, dynamic> dataJson = await _dataSource.getAll();

      final mapper = UserMapper();

      dataJson.forEach((key, value) {

        final User userMapped = mapper.fromMap( value );
        userMapped.id = key;

        if ( !_userList.contains( userMapped ) ) {
          _userList.add( userMapped );
        }

      });

      return _userList;
    
    } catch ( e ) {
      _logger.e( e );
      throw Exception('No se puede recuperar la lista de usuarios');
    } 

  }

  Future<User> getUserById( String id ) async {

    for (var oneUser in _userList) {
      if (oneUser.id == id ){
        return oneUser;
      }
    }

    try {

      final dataJson = await _dataSource.getById( id );

      final userMapped = UserMapper().fromMap( dataJson );
      userMapped.id = id;

      _userList.add( userMapped );
      
      return userMapped;

    } catch( e ) {
      _logger.e( e );
      throw Exception('No se pudo recuperar el user id: $id');
    }
  }


  Future<User> save( User newUser ) async {

    try {
      
      final dataJson = await _dataSource.save( newUser );

      final id = dataJson['name'];

      newUser.id = id;

      _userList.add( newUser );

      return newUser;
    
    } catch (e) {
      _logger.e( e );
      throw Exception('No se pudo crear el user en la api');
    }
  }

   Future<bool> delete( String id ) async {
    
    try {

      await _dataSource.delete( id );

      _userList.removeWhere((element) => element.id == id);

      return true;

    } catch (e) {
      _logger.e( e );
      throw Exception('No se pudo borrar el user de la api');
    }
  }

   Future<User?> update( String id, User userToUpdate ) async {

    try {

      userToUpdate.id = null;
      final dataJson = await _dataSource.update( id , userToUpdate );
      
      final User userUpdated = UserMapper().fromMap(dataJson);
      userUpdated.id = id;

      for (var oneUser in _userList) {
        if (oneUser.id == id) {

          oneUser.isActive = userUpdated.isActive;
          oneUser.mail = userUpdated.mail;
          oneUser.password = userUpdated.password;
          oneUser.role = userUpdated.role;
          oneUser.username = userUpdated.username;
          
          return oneUser;
        
        }
      }
    
    } catch (e) {
      _logger.e( e );
      throw Exception( 'No se pudo actualizar el user en api' );
    }

  }


}