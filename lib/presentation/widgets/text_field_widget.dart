

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {

  final String text;
  final IconData icon;
  final Function(String) onChanged;
  final bool obscureText;

  const TextFieldWidget({
    Key? key, 
    required this.text, 
    required this.icon, 
    required this.onChanged,
    this.obscureText = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      autocorrect: false,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: this.text,
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Icon( this.icon ),
        ), 
        border: OutlineInputBorder(
          borderSide: BorderSide.none, 
          borderRadius: BorderRadius.circular(24) ), 
      ),
    
      // validator: (value) => null ,

      onChanged: (value) {
        onChanged(value);
      },

    );
  }
}