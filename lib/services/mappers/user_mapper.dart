
import 'package:baseball_cards/models/user.dart';
import 'package:baseball_cards/services/mappers/base_mapper.dart';
import 'package:logger/logger.dart';

class UserMapper extends BaseMapper<User> {
  
  final Logger logger = Logger();
  
  @override
  User fromMap(Map<String, dynamic> json) {
     
    final User user;
    try {

      user = User(
        id        : json['id'],
        isActive  : json["isActive"] ?? (throw Exception(' "isActive" no se encuentra en el json' )),
        mail      : json["mail"] ?? (throw Exception(' "mail" no se encuentra en el json' )),
        password  : json["password"] ?? (throw Exception(' "password" no se encuentra en el json' )),
        role      : json["role"] ?? (throw Exception(' "role" no se encuentra en el json' )),
        username  : json["username"] ?? (throw Exception(' "username" no se encuentra en el json' )),
      );

      if (json['cards'] != null )
        user.cardList = (json['cards'] as List).map((e) => e.toString()).toList() ;
      return user;

    } catch (e) {
      logger.w( e );
      throw Exception( e );
    }
     
  }

  @override
  Map<String, dynamic> toMap(User user) {
    
    return {
        'id'        : user.id,
        "isActive"  : user.isActive,
        "mail"      : user.mail,
        "password"  : user.password,
        "role"      : user.role,
        "username"  : user.username,
        'cards'     : user.cardList,
    };
  }


}