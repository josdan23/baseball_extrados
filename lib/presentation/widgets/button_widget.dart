import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {

  final Color? colorBackground;
  final String text;
  final Color? colorText;
  final IconData? icon;
  final void Function()? onPressed;

  const ButtonWidget({
    Key? key, 
    this.colorBackground, 
    this.colorText,
    required this.text, 
    this.icon, 
    required this.onPressed
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MaterialButton(
      height: 56,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,

      color: colorBackground, 
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                text, 
                style: TextStyle(fontSize: 16, color: this.colorText, fontWeight: FontWeight.w600),
              ),
              
              this.icon != null
                ? const SizedBox(width: 16)
                : Container(),

              this.icon != null 
                ? Icon(this.icon, color: this.colorText)
                : Container()
            ],
          ),
        ),
      ),
      

      onPressed: onPressed,
    );

  }
}
