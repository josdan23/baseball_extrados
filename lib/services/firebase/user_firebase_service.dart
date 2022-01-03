
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;



import 'package:baseball_cards/services/mappers/user_mapper.dart';
import 'package:baseball_cards/services/config/server.dart';
import 'package:baseball_cards/services/users_api.dart';
import 'package:baseball_cards/models/user.dart';


//TODO: MANEJAR LOS CODIGOS DE LA REQUEST.

class UserFirebaseService extends UserApi {

  final Logger logger = Logger();

  @override
  Future<List<User>> getAll() async {

    final url = Uri.https( URL_SERVER, 'users.json');
    final response = await http.get( url );
    logger.d('RESPONSE_API_GET_ALL_USER: ${response.body}');

    final Map<String, dynamic> usersMap = json.decode( response.body );

    final List<User> usersList = [];

    usersMap.forEach((key, value) {
      final userTemp = UserMapper().fromMap(value);
      userTemp.id = key;

      usersList.add(userTemp);
    });

    logger.i('REQUIRE_ALL_USER_OK: $usersList');
    return usersList;
  }

  @override
  Future<User> getUserById( String userId) async {
  
    final url = Uri.https( URL_SERVER, 'users/$userId.json');
    final response = await http.get( url );

    logger.d( 'RESPONSE_API_GET_USER_BY_ID: ${response.body}' );

    final User user;
    
    try{

      user = UserMapper().fromMap( json.decode(response.body));
      user.id = userId;

      logger.i('REQUIRE_USER_BY_ID_OK: ${user.toString()}' );
      return user;
    
    } catch (e) {

      logger.d(e);
      throw Exception('No se pudo parsear');
    
    }
  }

  @override
  Future<void> delete(String userId) async {
   
    final url = Uri.https( URL_SERVER, 'users/$userId.json');
    final response = await http.delete(url);
    logger.d('RESPONSE_API_DELETE_USER_BY_ID: ${response.body}');

    logger.i('REQUIRE_DELETE_USER_BY_ID_OK: $userId');
    return;
  }

  @override
  Future<User> save(User userToSave) async {
    
    final url = Uri.https( URL_SERVER, 'users.json');

    final response = await http.post( 
      url, 
      body: userToSave.toJson()
    );
    logger.d('RESPONSE_API_SAVE_NEW_USER: ${response.body}');

    final map = json.decode( response.body );

    userToSave.id = map['name'];

    logger.i( 'REQUIRE_SAVE_NEW_USER_OK: ${userToSave.toString()}' );
    return userToSave;
  }


  @override
  Future<User> udpate(String userId, User user) async {

    final url = Uri.https( URL_SERVER, 'users/$userId.json');
    final response = await http.patch( url , body: UserMapper().toJson(user));

    logger.d('RESPONSE_API_UPDATE_USER: ${response.body}');

    final userUpdated = UserMapper().fromMap( json.decode(response.body ));

    logger.i( 'REQUIRE_UPDATE_USER_OK: $userUpdated');

    return userUpdated;
  }


}