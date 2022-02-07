
import 'package:baseball_cards/presentation/widgets/botton_nav_bar_widget.dart';
import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: const Text(
          'Mi Perfil', 
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold,
            fontSize: 24,
          )
        )
      ),
      bottomNavigationBar: BottonNavBarWidget(index: 1),
    );

  }
}