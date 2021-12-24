import 'dart:convert';

class User {
    User({
        this.isActive = true,
        required this.mail,
        required this.password,
        this.role = 'Collector',
        required this.username,
    });

    String? id;
    bool isActive;
    String mail;
    String password;
    String role;
    String username;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        isActive: json["isActive"],
        mail: json["mail"],
        password: json["password"],
        role: json["role"],
        username: json["username"],
    );

    Map<String, dynamic> toMap() => {
        "isActive": isActive,
        "mail": mail,
        "password": password,
        "role": role,
        "username": username,
    };

    @override
  String toString() {
    final sb = StringBuffer();
    sb
      ..write('User { id: ${this.id} - ')
      ..write('isActive: ${this.isActive} - ')
      ..write('mail: ${this.mail} - ')
      ..write('password: ${this.password} - ')
      ..write('role: ${this.role} - ')
      ..write('username: ${this.username} }');
  
    return sb.toString();
  }
}