import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:baseball_cards/models/user.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';
import 'package:baseball_cards/services/user_api.dart';


class LoginController extends ChangeNotifier {

  final UserApi userService;

  LoginController(this.userService);
  

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String mailForm = '';
  String passwordForm = '';

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }


  bool isValidForm() {
    print('$mailForm - $passwordForm');
    return formKey.currentState?.validate() ?? false;
  }


  Future<bool> authenticate( ) async {

    bool userValid = false;

    List<User> users = await userService.getAll();

    users.forEach((element) {
      
      print(element.toString());
      if ( element.mail == this.mailForm ) 
        if (element.password == this.passwordForm )
          userValid = true;
      
    });

    if (userValid)
      log('user autenticado');
  
    return userValid;
  }
}