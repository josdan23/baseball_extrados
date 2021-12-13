
import 'package:flutter/material.dart';

import 'package:baseball_cards/widgets/item_card_swiper.dart';
import 'package:card_swiper/card_swiper.dart';


class Home2Screen extends StatelessWidget {
  const Home2Screen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      //APPBAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Mis cartas', 
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold,
            fontSize: 24,
          )
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),

            onPressed: (){}, 
          ),
          SizedBox(width: 8,),
          CircleAvatar(
            child: Icon(Icons.person),
            backgroundColor: Colors.black12,
            foregroundColor: Colors.black,
          ),
          SizedBox(width: 16,),
        ],
      ),

      // BODY
      //backgroundColor: Colors.amber,
      body:  SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TextButton(onPressed: (){}, child: Text('Coleccion#')),
                  TextButton(onPressed: (){}, child: Text('Coleccion#')),
                  TextButton(onPressed: (){}, child: Text('Coleccion#')),
                  TextButton(onPressed: (){}, child: Text('Coleccion#')),
                  TextButton(onPressed: (){}, child: Text('Coleccion#')),
                  TextButton(onPressed: (){}, child: Text('Coleccion#')),
                  TextButton(onPressed: (){}, child: Text('Coleccion#')),
                ],
              ),
            ),
          
            SizedBox(height: 20,),
        
            Container(
              //color: Colors.amber,
              
              height: 500,
              //width: double.infinity,


              child: Swiper(
                
                itemBuilder: (BuildContext context,int index){

                  return CardItem();

                },
                itemCount: 10,
                viewportFraction: 0.8,
                scale: 0.9,
              ),
            ),

            Text('Serie'),
            Text('#90298023840'),
          ],
        )
      )
    );
  }
}