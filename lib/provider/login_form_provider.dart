
import 'dart:developer';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:baseball_cards/models/user.dart';

class LoginFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String mailForm = '';
  String passwordForm = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }


  final String _urlBase = 'flutter-cartas-default-rtdb.firebaseio.com';
  final List<User> users = [];

  LoginFormProvider() {
    this._loadUsers();
  }


  bool isValidForm() {

    print('$mailForm - $passwordForm');

    return formKey.currentState?.validate() ?? false;

  }


  Future _loadUsers() async {

    final url = Uri.https( _urlBase, 'users.json');
    final resp = await http.get( url );

    final Map<String, dynamic> usersMap = json.decode( resp.body );

    usersMap.forEach((key, value) {
      final userTemp = User.fromMap(value);
      userTemp.id = key;

      this.users.add(userTemp);
    });

    log('Se cargaron los usuarios desde el backend');
  }


  bool authenticate() {
    bool userValid = false;

    this.users.forEach((element) {
      
      print(element);
      if ( element.mail == this.mailForm ) 
        if (element.password == this.passwordForm ) 
          userValid = true;

    });

    if (userValid)
      log('user autenticado');

    return userValid;
  }
}