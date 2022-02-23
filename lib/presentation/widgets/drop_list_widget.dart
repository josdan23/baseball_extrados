
import 'package:baseball_cards/presentation/widgets/drop_down_menu_widget.dart';
import 'package:flutter/material.dart';

class DropListWidget extends StatelessWidget {

  final String label;
  final List<String> options;
  final Icon icon;
  final Function(String)? function;
  final String? initialValue;


  const DropListWidget({ 
    Key? key, 
    required this.label, 
    required this.options, 
    required this.icon,
    required this.function,
    this.initialValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: 16),

        Text(
          label, 
          style: const TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.w600, 
            color: Colors.black45
          ),
        ),

        const SizedBox(height: 8,),

        DropDownMenuWidget(
          icon: icon ,
          dropdownItemValue: initialValue,
          listOfItems: options,
          function: this.function,
        ),
      ],
    );
  }
}