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
      initialRoute: 'home',
      routes: {
        
        'home'      : ( BuildContext context ) => HomeScreen(),
        'details'   : (BuildContext context ) => DetailsScreen(),
      },


    );
  }
}