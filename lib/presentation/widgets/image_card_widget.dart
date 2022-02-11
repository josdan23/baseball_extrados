import 'package:flutter/material.dart';

class ImageCardWidget extends StatelessWidget {

  final String urlImage;

  const ImageCardWidget({
    Key? key, 
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: FadeInImage(
        placeholder: AssetImage('assets/baseball_loading.gif'),
        image: NetworkImage(this.urlImage),
        fit: BoxFit.cover,
        
      )
    );
  }
}