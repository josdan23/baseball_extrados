
import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: (){},
        ),
        elevation: 0,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text('Mis cartas', style: TextStyle(color: Colors.black, fontSize: 3, fontWeight: FontWeight.w700)),
          ),
          SizedBox(height: 24,),
          Container(
            height: 500,
            width: double.infinity,
            child: Swiper(
              
              itemBuilder: (BuildContext context,int index){

                return _CardItem();

              },
              itemCount: 10,
              viewportFraction: 0.8,
              scale: 0.9,
            ),
          ),
        ]
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'details');
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 12),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              child: FadeInImage(
                placeholder: NetworkImage('https://via.placeholder.com/350x150'),
                image: AssetImage('assets/riquelme.jpeg'),
                fit: BoxFit.cover
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.1), // near the top right
                  radius: 0.9,
                  colors: <Color>[
                    Color.fromRGBO(33, 29, 28, 0.1), // blue sky
                    Color.fromRGBO(223, 205, 49 , 0.8), // blue sky
                     // yellow sun
                  ],
                  stops: <double>[0.4, 1.0],
                ),
              )
            ),
    
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              
              children: [
    
                Container(
                  child: FadeInImage(
                    width: 50,
                    image: AssetImage('assets/boca_logo.png'),
                    placeholder: NetworkImage('https://via.placeholder.com/50x50'),),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                ),
    
                Text('Juan Román', style: TextStyle(fontSize: 16, color: Colors.white)),
                Text('Riquelme', style: TextStyle(fontSize: 36, color: Colors.white)),
                SizedBox(height: 40),
              ],
            )
    
            
          ]
        ),
      ),
    );
  }
}
