import 'dart:ui';

import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(children: [
          Text('S-012'),
          Text('GOLD', style: TextStyle(fontSize: 10, color: Colors.yellow),)
        ],),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
     
      body: Stack(
        
        children: [

          _ImageBackground(),

          //_GradientBackground(),

          Container(
            //padding: EdgeInsets.symmetric(horizontal: 16),

            child: SafeArea(
              bottom: false,
              child: Column(
                
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  _Colection(),

                  Expanded(child: Container()),
                  //backgrond-card
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(42),
                   
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.black54,
                          Color.fromRGBO(230, 175, 11, 0.7),
                        ],
                        stops: [
                          0.2, 1
                        ]
                      ),
                    ), 
                    
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        _Club(),
                            
                        SizedBox(height: 40,),
                              
                        _NamePlayer(),
                
                        SizedBox(height: 25,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _InfoItem( info: 'Delantero', icon: Icons.directions_run_rounded ),
                            _InfoItem( info: '38 años', icon: Icons.perm_contact_calendar_sharp),
                            _InfoItem( info: 'Argentino', icon: Icons.flag ),
                          ],
                        ),
                        
                        SizedBox(height: 54,),
                
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}

class _Colection extends StatelessWidget {
  const _Colection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rate_rounded, size: 16, color: Colors.white),
          SizedBox(width: 8,),
          Text('Colección', style: TextStyle(fontSize: 16, color: Colors.white),),
          SizedBox(width: 8,),
          Icon(Icons.star_rate_rounded, size: 16, color: Colors.white),
        ],
      )
    );
  }
}

class _GradientBackground extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black12,
            Colors.black45,
            //Color.fromRGBO(255,255,0, 0.3),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {

  final String info;
  final IconData icon;

  const _InfoItem({
    required this.info, 
    required this.icon
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon( this.icon , color: Colors.white, size: 24,),
          SizedBox(width: 8,),
          Text( this.info, style: TextStyle(color: Colors.white, fontSize: 14))
        ],
      ),
    );
  }
}

class _Club extends StatelessWidget {
  const _Club({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FadeInImage(
          height: 40,
          placeholder: NetworkImage('https://via.placeholder.com/100x100'),
          image: AssetImage('assets/boca_logo.png'),
        ),

        SizedBox(width: 8,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Boca Juniors', style: TextStyle( fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600,),),
            Text('Argentina', style: TextStyle( fontSize: 16, color: Colors.white60, fontWeight: FontWeight.normal,),)
          ],
        ),
         
      ],
    );
  }
}

class _NamePlayer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Juan Román', style: TextStyle(fontSize: 26, color: Colors.white),),
        Text('Riquelme', style: TextStyle(fontSize: 42, color: Colors.white, fontWeight: FontWeight.w500),),
      ],
    );
  }
}

class _ImageBackground extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Container (  
      
      height: double.infinity,
      child: FadeInImage(
        placeholder: NetworkImage('https://via.placeholder.com/200x300'),
        image: AssetImage('assets/riquelme.jpeg'),
        fit: BoxFit.cover,
      ),
    );
  }
}