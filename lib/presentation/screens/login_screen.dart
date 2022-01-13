import 'package:baseball_cards/controllers/login_controller.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';
import 'package:baseball_cards/services/users_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baseball_cards/presentation/blocs/login_bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final UserApi userDataProvider = UserFirebaseService();
    final LoginController controller = LoginController(userDataProvider);
    
 
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        
        child: BlocProvider(
          create: ( _ ) => LoginBloc(controller),
          child: _LoginForm(),
        )
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        
        if( state is SuccessLogin)
          Navigator.pushReplacementNamed(context, 'home');
        
        if( state is FailureLogin ) 
          _showSnackBar(context);

      },
      child: Form(
          // key: loginFormProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
    
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
    
              const Text(
                'Bievenido',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black87 )
              ),
            
              const SizedBox(height: 36,),
    
            //INPUT PARA EL MAIL
             _EmailInput(),
    
              const SizedBox(height: 24,),
            
              // INPUT PARA EL PASSWORD
              _PasswordInput(),
              
              const SizedBox(height: 24,),
            
              _LoginButton()
    
            ],
          )
        ),
    );
  }


  void _showSnackBar(BuildContext context) {
   
    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
      content: Text('Usuario o contraseña incorrectos')
    ));
  }
}


class _LoginButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {


        return MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          color: Colors.blueAccent,
          child: Container(
            height: 56,
            width: double.infinity,
            alignment: Alignment.center,
            child: 

              (state is ValidatingForm )
                ? const CircularProgressIndicator(
                  color: Colors.white,

                )

                : const Text(
                  'Iniciar Sesión',
                  style: TextStyle( color: Colors.white, fontSize: 16)) 
          ),
          
          onPressed: ()  {
  
            BlocProvider.of<LoginBloc>(context).add( LoginFormSubmitted() );

          }, 
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      
      return BlocBuilder<LoginBloc, LoginState>(

        builder: (context, state) {
          return TextFormField(
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'Ingrese su mail',
              prefixIcon: const Icon(Icons.mail), 
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),), 
            ),
          
            validator: (value) => null ,
      
            onChanged: (value) {
              BlocProvider.of<LoginBloc>(context).add(EmailChanged(value));
            },
      
          );
        },
      );
  }
}

class _PasswordInput extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: 'Ingrese su password',
            prefixIcon: const Icon(Icons.lock) , 
          ),
    
          validator: (value) => null,
          
          onChanged: ( value ) {
            BlocProvider.of<LoginBloc>(context).add( PasswordChanged( value ));
          },
         
        );
      },
    );  
  }

}

