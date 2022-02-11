import 'package:flutter/material.dart';


class DropDownMenuWidget extends StatelessWidget {
  
  final List<String> listOfItems;
  final String? labelText;
  final Icon? icon;
  String dropdownItemValue = '';
  final Function(String)? function;

  DropDownMenuWidget({
    Key? key,
    this.labelText = '',
    this.icon,
    required this.listOfItems,
    this.function
  }) : super(key: key) {
    
    dropdownItemValue = listOfItems[0];
  }


  @override
  Widget build(BuildContext context) {
   return DropdownButtonFormField<String>(
      value: dropdownItemValue,

      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: this.icon 
        ),
        labelText: labelText,
        fillColor: Colors.grey.shade200,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none, 
          borderRadius: BorderRadius.circular(24) 
        ), 
      ),
      items: listOfItems.map((e) {
        return DropdownMenuItem<String>(
            value: e,
            child: Text( e ),
          );
      }).toList(),

      onChanged: ( value ) {
        dropdownItemValue = value!;
        
        if ( function != null)
          this.function!(value);
      },

    );
  }
}