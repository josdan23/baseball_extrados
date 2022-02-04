part of 'login_bloc.dart';


enum StateForm {
  INITIAL_FORM,
  VALIDATING_FORM,
  VALID_FORM,
  WRONG_FORM,
}

class LoginState {

  final String mail;
  final String password;
  final StateForm stateForm;

  LoginState({this.mail = '', this.password = '', this.stateForm = StateForm.INITIAL_FORM});

  LoginState copyWith({
    String? mail,
    String? password,
    StateForm? stateForm
  }) {

    return LoginState(
      mail: mail ?? this.mail,
      password: password ?? this.password,
      stateForm: stateForm ?? this.stateForm,
    );

  }

}