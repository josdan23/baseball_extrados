
import 'package:baseball_cards/models/user.dart';

abstract class UserApi {

  Future<List<User>> getAll();

  Future<User> getUserById( String userId);

}