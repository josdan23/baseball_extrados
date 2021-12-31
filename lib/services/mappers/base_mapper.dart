

import 'dart:convert';

abstract class BaseMapper<T> {

  T fromMap( Map<String, dynamic> json );

  Map<String, dynamic> toMap( T ojbject );

  String toJson( T object ) {
    return json.encode( toMap(object));
  }
}