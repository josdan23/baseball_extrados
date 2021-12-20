import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:baseball_cards/provider/login_form_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        
        child: ChangeNotifierProvider(
          create: ( _ ) => LoginFormProvider(),
          child: _LoginForm(),
        ),
      )
    );
  }
}

class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginFormProvider = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginFormProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            'Bievenido',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black87 )
          ),
        
          SizedBox(height: 36,),
        

        //INPUT PARA EL MAIL
          TextFormField(
            autocorrect: false,
            decoration: buildInputDecoration(
              prefix: Icon(Icons.mail), 
              hintText: 'Ingrese su mail'),

            onChanged: ( value ) => loginFormProvider.mailForm = value,
            
            validator:(value) {
              
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = new RegExp(pattern);
              
              return regExp.hasMatch(value ?? '')
                ? null
                : 'El correo es incorrecto';
            },
          ),
        
          SizedBox(height: 24,),
        
        // INPUT PARA EL PASSWORD
          TextFormField(
            obscureText: true,
            decoration: buildInputDecoration(
              hintText: 'Ingrese su password',
              prefix: Icon(Icons.lock)
            ),

            onChanged: ( value ) => loginFormProvider.passwordForm = value,
            
            validator: (value) {
        
              return ( value != null && value.length >= 6 ) 
                ? null
                : 'La contraseña debe de ser de 6 caracteres';  
            },
          ),
        
          SizedBox(height: 24,),
        
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            color: Colors.blueAccent,
            child: Container(
              height: 56,
              width: double.infinity,
              alignment: Alignment.center,
              child: loginFormProvider.isLoading 
                ? CircularProgressIndicator(
                  color: Colors.white, 
                )
                : Text(
                    'Iniciar Sesión',
                    style: TextStyle( color: Colors.white, fontSize: 16)
                  )   
            ),
            
            onPressed: () async {
        
              FocusScope.of(context).unfocus();
        
              if (!loginFormProvider.isValidForm()) return;
              if( !loginFormProvider.authenticate() ) return;

              loginFormProvider.isLoading = true;

              // await Future.delayed(Duration(seconds: 2));

              loginFormProvider.isLoading = false;
        
              Navigator.pushReplacementNamed(context, 'home');
        
            }, 
          )
        ],
      )
    );
  }

  InputDecoration buildInputDecoration({
    required Icon prefix, 
    required String hintText }) {
    return InputDecoration(
            // labelText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
            prefixIcon: prefix, 
          );
  }
}