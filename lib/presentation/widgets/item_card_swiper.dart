
import 'package:flutter/material.dart';

import 'package:baseball_cards/models/card.dart' as bscard;


class CardItem extends StatelessWidget {

  final bscard.Card card;

  const CardItem({
    Key? key, 
    required this.card
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
                  Navigator.pushNamed(context, 'details', arguments: {'idCard': card.idCard});
                
                },

                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children:  [
                      
                      _ImageCard( url: card.image ),


                      _FilterCard( raritie: card.rarities.description, ),
              
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
              
                            Text( card.player.firstName, style: TextStyle(fontSize: 16, color: Colors.white)),
                            
                            Text( card.player.lastName, style: TextStyle(fontSize: 36, color: Colors.white)),
              
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
          Text(card.serie.description, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class _FilterCard extends StatelessWidget {
  
  final String raritie;

  const _FilterCard({
    Key? key, 
    required this.raritie
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
            colorRaritie( raritie ),
          ],
          stops: <double>[0.4, 1.0],
        ),
      )
    );
  }

  //FIXME: cambiar el color
  Color colorRaritie( String raritie) {

    switch (raritie) {
      case 'gold':
        return const Color.fromRGBO(223, 205, 49 , 0.8);
      case 'silver':
        return const Color.fromRGBO(174, 172, 172 , 0.8); 
      case 'bronze':
        return const Color.fromRGBO(199, 116, 66 , 0.8);
      
      default:
        return const Color.fromRGBO(174, 172, 172 , 0.8); 

    }
  }
}

class _ImageCard extends StatelessWidget {

  final String? url;

  const _ImageCard({
    required this.url
  });



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.55,
      child: FadeInImage(
        placeholder: AssetImage('assets/placeholder.png'),
        image: NetworkImage( this.url ?? 'https://via.placeholder.com/200x350' ),
        fit: BoxFit.cover,
      ),
    );
  }
}

