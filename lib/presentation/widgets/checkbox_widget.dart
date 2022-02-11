

import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {

  final String title;
  final Function(bool) onChanged;

  const CheckboxWidget({ Key? key,
    required this.title,
    required this.onChanged
  }) : super(key: key);

  @override
  _CheckboxWidgetState createState( ) => _CheckboxWidgetState( title , onChanged );
}

class _CheckboxWidgetState extends State<CheckboxWidget> {

  final String title;
  final void Function(bool) onChanged;
  bool _value = false;

  _CheckboxWidgetState(this.title, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title),
      value: _value, 
      onChanged: ( value ) {
        _value = value!;

        onChanged( _value );
        setState(() {
          
        });

      });
  }
}