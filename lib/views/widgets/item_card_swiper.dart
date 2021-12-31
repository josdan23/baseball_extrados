
import 'package:flutter/material.dart';


class CardItem extends StatelessWidget {

  final String firstName;
  final String lastName;

  const CardItem({
    Key? key, 
    required this.firstName, 
    required this.lastName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Container(
      // color: Colors.red,    
      child: Column(
        children: [
          
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              GestureDetector(
                onTap: () {

                  //TODO: mandar info del jugador para ver los detalles
                  Navigator.pushNamed(context, 'details');
                
                },

                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children:  [
                      
                      _ImageCard(),
              
                      //TODO: cambiar el color del filtro según la rareza
                      _FilterCard(),
              
                      Container(
                        // color: Colors.red,
                        height: MediaQuery.of(context).size.height * 0.55,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
              
                            FadeInImage(
                              height: 50,
                              placeholder: AssetImage('assets/boca_logo.png'), 
                              image: AssetImage('assets/boca_logo.png')
                            ),
              
                            SizedBox(height: 20,),
              
                            Text( this.firstName, style: TextStyle(fontSize: 16, color: Colors.white)),
                            
                            Text( this.lastName, style: TextStyle(fontSize: 36, color: Colors.white)),
              
                            SizedBox(height: 30,)
                          ]
                        )
                      ),
              
                    ]
                  ),
                ),
              ),

            ] 
          ),

          SizedBox(height: 20,),
          
          Text('SERIE'),
          Text('3902300330', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class _FilterCard extends StatelessWidget {
  
  final Color? colorFilter;

  const _FilterCard({
    Key? key, 
    this.colorFilter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.1), 
          radius: 0.9,
          colors: [
            Color.fromRGBO(33, 29, 28, 0.1),
            this.colorFilter ?? Color.fromRGBO(223, 205, 49 , 0.8), 
          ],
          stops: <double>[0.4, 1.0],
        ),
      )
    );
  }
}

class _ImageCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.55,
      child: Image(
        image: AssetImage('assets/riquelme.jpeg'),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

