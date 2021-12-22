
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:baseball_cards/models/user.dart';

class UserServices {

  static final String USER_URL = 'flutter-cartas-default-rtdb.firebaseio.com';
  // static final String USER_URL = 'flutter-cartas-default-rtdb.firebaseio.com/user.json';


  static Future<List<User>> getAllUsers() async {

    final url = Uri.https( USER_URL, 'users.json');
    // final url = Uri.parse( USER_URL );

    final resp = await http.get( url );

    final Map<String, dynamic> usersMap = json.decode( resp.body );

    final List<User> usersList = [];

    usersMap.forEach((key, value) {
      final userTemp = User.fromMap(value);
      userTemp.id = key;

      usersList.add(userTemp);
    });

    log('Se solicitarón los usuarios del backend');

    return usersList;
  }

  static Future<User> getUserById( String idUser) async {
    //TODO: Implementar getUserById(String id)
    return User(mail: '', password: '', username: '');
  }

  static Future<User> udpateUserById( String idUser) async {
    //TODO: implementar updateUserById()
    return User(mail: '', password: '', username: '');
  } 


}