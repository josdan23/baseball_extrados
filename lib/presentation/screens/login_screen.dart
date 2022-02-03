import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baseball_cards/controllers/login_controller.dart';
import 'package:baseball_cards/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:baseball_cards/presentation/widgets/button_widget.dart';
import 'package:baseball_cards/presentation/widgets/text_field_widget.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final LoginController controller = LoginController(UserFirebaseService());
  
    return Scaffold(
      body: Padding(

        padding: const EdgeInsets.symmetric(horizontal: 20),
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
        
        // if( state is FailureLogin ) 
          // _showSnackBar(context);

      },
      child: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            
              child: Column(
        
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
        
                children: [
        
                  Container(
                    color: Colors.grey[100],
                    height: 180,
                  ),
      
                  SizedBox(height: 24),
        
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child:  _HeaderText(),
                  ),
                
                  SizedBox(height: 50),
            
                  _EmailInput(),
            
                  SizedBox(height: 24),
      
                  _PasswordInput(),
                  
                  SizedBox(height: 20),
      
                  Text('Correo o contraseña incorrecta', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  
                  SizedBox(height: 36),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
        
                      _RegisterButton(),
        
                      _LoginButton()
                    ],
                  ),
            
                ],
              )
            ),
        ),
      ),
    );
  }

}

class _HeaderText extends StatelessWidget {
  const _HeaderText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return RichText(
      text: const TextSpan(
        style: TextStyle(fontSize: 32, color: Colors.black87, fontWeight: FontWeight.w600),
        children: <TextSpan> [
          TextSpan(
            text: 'Colecciona',
            style: TextStyle(color: Colors.purple)
          ),
          TextSpan(
            text: ' a todos tus deportistas favoritos en un      solo lugar'
          )
        ]
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      text: 'Registro',
      colorText: Colors.purple,
      onPressed: (){
        print('registrarse');
      }, 
    );
  }
}


class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      colorBackground: Colors.purple, 
      colorText: Colors.white,
      text: 'Iniciar Sessión', 
      icon: Icons.arrow_forward_rounded, 
      onPressed: ()  {
        print('Iniciar sesión');
      }
    );
  }
}



class _EmailInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      
      return BlocBuilder<LoginBloc, LoginState>(

        builder: (context, state) {

          return TextFieldWidget(
            text: 'Mail', 
            icon: Icons.mail, 
            onChanged: ( value ) {
              print(value);
            }
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
        return TextFieldWidget(
            text: 'Contraseña', 
            icon: Icons.lock, 
            onChanged: ( value ) {
              print(value);
            }
          );
      },
    );  
  }

}

