
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:baseball_cards/controllers/login_controller.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final LoginController controller;

  LoginBloc(this.controller) : super(LoginState()) {
    on<EmailChanged>( _onLoginEmailChange );
    on<PasswordChanged>( _onLoginPasswordChange );
    on<LoginFormSubmitted>( _onLoginFormSubmitted );
    on<RegisterPressed>( _onRegisterPressed );
  }

  void _onLoginEmailChange(EmailChanged event, Emitter<LoginState> emit) {

    print('Event email: ${event.email}');
    emit( state.copyWith(mail: event.email) );

  }

  void  _onLoginPasswordChange(PasswordChanged event, Emitter<LoginState> emit) {

      print('Event password: ${event.password}');
      emit( state.copyWith( password: event.password ) );
    
  }


  void _onLoginFormSubmitted(LoginFormSubmitted event, Emitter<LoginState> emit) async {
    
    emit( state.copyWith(stateForm: StateForm.VALIDATING_FORM) );

    print('estadoEmail: ${state.mail}');
    print('estadoPassword: ${state.password}');

    final isAuthenticate = await controller.authenticate(state.mail, state.password );

    (isAuthenticate) 
      ? emit( state.copyWith(stateForm: StateForm.VALID_FORM) )
      : emit( state.copyWith(stateForm: StateForm.WRONG_FORM) );

  }

  void _onRegisterPressed(RegisterPressed event, Emitter<LoginState> emit) {

    print('Se solicitar registro');

  }
}
