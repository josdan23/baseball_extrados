

import 'dart:convert';
import 'dart:developer';
import 'package:baseball_cards/services/user_api.dart';
import 'package:http/http.dart' as http;

import 'package:baseball_cards/models/user.dart';

class UserFirebaseService extends UserApi {

  static final String USER_URL = 'flutter-cartas-default-rtdb.firebaseio.com';

  Future<List<User>> getAll() async {

    final url = Uri.https( USER_URL, 'users.json');

    final resp = await http.get( url );

    final Map<String, dynamic> usersMap = json.decode( resp.body );

    log('GET_USER_API: $usersMap');

    final List<User> usersList = [];

    usersMap.forEach((key, value) {
      final userTemp = User.fromMap(value);
      userTemp.id = key;

      usersList.add(userTemp);
    });

    log('Se solicitarón los usuarios del backend');
 

    return usersList;
  }


  Future<User> getUserById( String idUser) async {
    //TODO: Implementar getUserById(String id)
    return User(mail: '', password: '', username: '');
  }

}