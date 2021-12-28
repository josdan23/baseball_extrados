
import 'package:baseball_cards/models/user.dart';

abstract class UserApi {

  Future<List<User>> getAll();

  Future<User> getUserById( String userId);

  Future<User> save( User user );

  Future<void> delete( String userId );

  Future<User> udpate( String userId, User user);

}