part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {

  final String mail;
  final String password;

  LoginInitial({
    this.mail = '', 
    this.password = '',
  });

  LoginInitial copyWith({
    String? mail,
    String? password,
  }) {
    return LoginInitial(
      mail: mail ?? this.mail, 
      password: password ?? this.password
    );
  }
}


class ValidatingForm extends LoginState {}

class SuccessLogin extends LoginState {}

class FailureLogin extends LoginState {}
