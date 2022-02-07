

import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {

  final IconData icon;
  final Function() onPresss;

  const ActionButton({ 
    Key? key, 
    required this.icon, 
    required this.onPresss }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 2),
      child: Container(

        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(22),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: IconButton(
            icon: Icon(this.icon, color: Colors.black54,), 
            onPressed: this.onPresss,
          ),
        ),
      ),
    );
  }
}