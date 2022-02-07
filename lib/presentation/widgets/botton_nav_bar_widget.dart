

import 'package:flutter/material.dart';

class BottonNavBarWidget extends StatelessWidget {


  const BottonNavBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      currentIndex: 1,

      items: const <BottomNavigationBarItem> [

        BottomNavigationBarItem(
          icon: _IconNavBar( icon: Icons.collections,),
          label: 'Mi colección'),

        BottomNavigationBarItem(
          icon: _IconNavBar(icon: Icons.person_outline), 
          label: 'Mi perfil'),

      ],
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

