
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        
        // color: Colors.red,
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 50,),
              
              Text(
                'Bievenido',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black87 )
              ),

              SizedBox(height: 36,),


              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  // labelText: 'Mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),

                  ),
                  // filled: true,
                  // fillColor: Colors.black12,
                  hintText: 'Ingrese su mail',
                  prefixIcon: Icon(Icons.mail)
                ),
                validator:(value) {
                  
                  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  = new RegExp(pattern);
                  
                  return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El correo es incorrecto';
                },
              ),
      
              SizedBox(height: 24,),
      
      
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  // labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Ingrese su password',
                  prefixIcon: Icon(Icons.lock),
                ),
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
                  child: Text('Iniciar Sesión')   
                ),
                onPressed: (){

                  FocusScope.of(context).unfocus();
      

                  // Navigator.pushReplacementNamed(context, 'home');


                  //TODO: validar los textfields
      
                }, 
              )
      
      
      
            ],
          )
        ),
      )
    );
  }
}