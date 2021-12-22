import 'package:baseball_cards/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:baseball_cards/screens/home_screen.dart';
import 'package:baseball_cards/screens/details_screen.dart';



void main() {

  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        
        'login'     : ( _ ) => LoginScreen(),
        'home'      : ( BuildContext context ) => HomeScreen(),
        'details'   : ( BuildContext context ) => DetailsScreen(),
      },


    );
  }
}