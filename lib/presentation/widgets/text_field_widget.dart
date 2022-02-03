

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {

  final String text;
  final IconData icon;
  final Function(String) onChanged;

  const TextFieldWidget({
    Key? key, 
    required this.text, 
    required this.icon, 
    required this.onChanged 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      autocorrect: false,
      decoration: InputDecoration(
        hintText: this.text,

        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Icon( this.icon ),
        ), 
        border: OutlineInputBorder( borderRadius: BorderRadius.circular(24) ), 
      ),
    
      // validator: (value) => null ,

      onChanged: (value) {
        onChanged(value);
      },

    );
  }
}