

import 'package:flutter/material.dart';


class BottonNavBarWidget extends StatefulWidget {

  final int index;

  const BottonNavBarWidget({
    Key? key, 
    required this.index
  }) : super(key: key);

  @override
  State<BottonNavBarWidget> createState() => _BottonNavBarWidgetState( this.index );
}

class _BottonNavBarWidgetState extends State<BottonNavBarWidget> {

  int _currentIndex  = 0;

  _BottonNavBarWidgetState( int index ){
    _currentIndex = index;
  }

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

        _currentIndex = index;

        switch (_currentIndex) {
          case 0:
            Navigator.of(context).pushReplacementNamed('home');
            break;

          case 1:
            Navigator.of(context).pushReplacementNamed('perfil');
            break;
          
          default:
            Navigator.of(context).pushReplacementNamed('home');

        }

        setState(() {
          
        });

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

