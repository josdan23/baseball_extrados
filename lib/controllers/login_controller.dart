import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:baseball_cards/data/repositories/user_repo.dart';
import 'package:baseball_cards/models/user.dart';
import 'package:baseball_cards/services/users_api.dart';

class LoginController extends ChangeNotifier {

  final Logger _logger = Logger();

  // final UserApi _userService;

  final UserRepo _repo;

  LoginController( UserApi userService ) : _repo = UserRepo.getInstance(userService);

  // LoginController(UserApi userService) : _userService = userService;
  

  Future<bool> authenticate( String email, String password ) async {

    bool userValid = false;

    // List<User> users = await _userService.getAll();

    List<User> users = await _repo.getAllUsers();

    users.forEach((element) {
      
      // print(element.toString());

      if ( element.mail == email ) {
        if (element.password == password ) 
          userValid = true;
      }
          
    });

    if (userValid)
      _logger.i('USER_AUTHENTICATED'); 
  
    return userValid;
  }
}