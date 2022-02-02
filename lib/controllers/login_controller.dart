import 'package:logger/logger.dart';

import 'package:baseball_cards/data/repositories/user_repo.dart';
import 'package:baseball_cards/models/user.dart';
import 'package:baseball_cards/services/users_api.dart';

class LoginController {

  final UserRepo _repo;
  final Logger _logger = Logger();


  LoginController( UserApi userService ) : _repo = UserRepo.getInstance(userService);
  

  Future<bool> authenticate( String email, String password ) async {

    bool userValid = false;

    List<User> users = await _repo.getAllUsers();

    users.forEach((element) {    
      if ( element.mail == email ) {
        if (element.password == password ) {
          userValid = true;
          _repo.userAuthenticated = element;
        }
      }  
    });

    if (userValid){
      _logger.i('USER_AUTHENTICATED'); 
    }
  
    return userValid;
  }
}