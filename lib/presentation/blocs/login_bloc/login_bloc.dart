
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:baseball_cards/controllers/login_controller.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final LoginController controller;

  LoginBloc(this.controller) : super(LoginInitial()) {
    on<EmailChanged>( _onLoginEmailChange );
    on<PasswordChanged>( _onLoginPasswordChange );
    on<LoginFormSubmitted>( _onLoginFormSubmitted );
  }

  void _onLoginEmailChange(EmailChanged event, Emitter<LoginState> emit) {

    final estado = state as LoginInitial;
    print('Event email: ${event.email}');

    emit( estado.copyWith(mail: event.email));

  }

  void  _onLoginPasswordChange(PasswordChanged event, Emitter<LoginState> emit) {

      final mystate = state as LoginInitial;
      print('Event password: ${event.password}');
  
      emit( mystate.copyWith( password: event.password));
    
  }


  void _onLoginFormSubmitted(LoginFormSubmitted event, Emitter<LoginState> emit) async {
    
    final initialState = state as LoginInitial;

    emit( ValidatingForm());

    print('estadoEmail: ${initialState.mail}');
    print('estadoPassword: ${initialState.password}');

    final isAuthenticate = await controller.authenticate(initialState.mail, initialState.password );

    if (isAuthenticate)
      emit(SuccessLogin());
    else
      emit(FailureLogin());
    emit( initialState.copyWith());
    
  }
}
