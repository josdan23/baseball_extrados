import 'package:logger/logger.dart';

import 'package:baseball_cards/data/repositories/user_repo.dart';
import 'package:baseball_cards/models/user.dart';
import 'package:baseball_cards/services/users_api.dart';

class LoginController {

  final UserRepo _repo;
  final Logger _logger = Logger();


  LoginController( UserApi userService ) : _repo = UserRepo.getInstance(userService);
  

  Future<bool> authenticate( String email, String password ) async {

    List<User> users = await _repo.getAllUsers();

    for( var user in users) { 
      if ( user.mail == email ) {
        if (user.password == password ) {

          _logger.d('USER_ID: ${user} AUTHENTICATED!');
          _repo.userAuthenticated = user;
          print(_repo.userAuthenticated);
          
          return true;
        }
      }  
    }
    
    print('Usuario NO autenticado');
    return false;
  }

}