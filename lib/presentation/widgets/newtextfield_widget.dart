import 'package:baseball_cards/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';


class NewTextFieldWidget extends StatelessWidget {

  final String label;
  final String? initialValue;
  final Function(String) onChanged;

  const NewTextFieldWidget({ 
    Key? key, 
    required this.label, 
    required this.onChanged,
    this.initialValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: 16,),

        Text(
          label, 
          style: const TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.w600, 
            color: Colors.black45
          ),
        ),

        const SizedBox(height: 8,),

        TextFieldWidget(
          text: label, 
          icon: Icons.person, 
          intialValue: this.initialValue,
          onChanged: onChanged
        ),
      ],
    );
  }
}