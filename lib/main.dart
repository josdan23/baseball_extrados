import 'package:baseball_cards/presentation/screens/create_card_screen.dart';
import 'package:baseball_cards/presentation/screens/perfil_screen.dart';
import 'package:flutter/material.dart';

import 'package:baseball_cards/presentation/screens/login_screen.dart';
import 'package:baseball_cards/presentation/screens/home_screen.dart';
import 'package:baseball_cards/presentation/screens/details_screen.dart';



void main() {

  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'create_card',
      routes: {
        
        'login'     : ( _ ) => LoginScreen(),
        'home'      : ( _ ) => HomeScreen(),
        'details'   : ( _ ) => DetailsScreen(),
        'create_card'    : ( _ ) => CreateCardScreen(),
        'perfil'    : ( _ ) => PerfilScreen(),
      },


    );
  }
}