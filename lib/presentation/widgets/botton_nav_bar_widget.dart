

import 'package:flutter/material.dart';


class BottonNavBarWidget extends StatefulWidget {


  const BottonNavBarWidget({Key? key}) : super(key: key);

  @override
  State<BottonNavBarWidget> createState() => _BottonNavBarWidgetState();
}

class _BottonNavBarWidgetState extends State<BottonNavBarWidget> {

  int _currentIndex  = 0;

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
  
      items: const <BottomNavigationBarItem> [  
        BottomNavigationBarItem(
          icon: _IconNavBar( icon: Icons.collections,),
          label: 'Mi colección'),
    
        BottomNavigationBarItem(
          icon: _IconNavBar(icon: Icons.person_outline), 
          label: 'Mi perfil'),
      ],

      currentIndex: _currentIndex,

      onTap: ( index ) {

        setState(() {
          _currentIndex = index;
        });

        //TODO: CAMBIAR DE PAGINA

      },

      
    );
  }
}

class _IconNavBar extends StatelessWidget {

  final IconData icon;

  const _IconNavBar({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4),
      child: Icon( this.icon ),
    );
  }
}

