import 'package:baseball_cards/controllers/cards_controller.dart';
import 'package:baseball_cards/services/firebase/card_firebase_services.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baseball_cards/presentation/blocs/details_bloc/details_bloc.dart';

class DetailsScreen extends StatelessWidget {

  final CardController _controller = CardController( CardFirebaseServices(), UserFirebaseService());
  
  DetailsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return BlocProvider(
      create: (context) {
        final bloc = DetailsBloc( _controller );
       
        bloc.add(GetDetails(arguments['idCard']));

        return bloc;
      },
      child: _DetailsCard()
    );
  }
}

class _DetailsCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    extendBodyBehindAppBar: true,
    appBar: _createAppBar(context),
    
    body: BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) {

        if (state is LoadingDetails) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        state as DetailsInitial;

    

        return Stack(    
          children: [
  
            _ImageBackground( url: state.image ?? 'https://via.placeholder.com/200x350' ),
  
            //_GradientBackground(),
  
            SafeArea(
              bottom: false,
              child: Column(
                
                children: [
  
                  _Colection(),
  
                  Expanded(child: Container()),
                  
                  //todo: backgrond-card
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(42),
                    
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.black54,
                          colorRaritie( state.rarity ?? '' )
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
                        
                        _Club( clubName: state.team ?? 'equipo', country: 'Argentina',),
                            
                        SizedBox(height: 40,),
                              
                        _NamePlayer( 
                          firstName: state.firstNamePlayer ?? 'primernombre',
                          lastName: state.lastNamePlayer ?? 'segundo nombre'
                        ),
                
                        SizedBox(height: 25,),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _InfoItem( info: state.rolePlayer ?? 'role', icon: Icons.directions_run_rounded ),
                            _InfoItem( info: state.serie ?? 'serie', icon: Icons.perm_contact_calendar_sharp),
                            _InfoItem( info: state.rarity ?? 'rareza', icon: Icons.flag ),
                          ],
                        ),
                        
                        SizedBox(height: 54,),
                
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

      }
    )
  );
}

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

AppBar _createAppBar(BuildContext context) {
  return AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
  }


class _Colection extends StatelessWidget {
  
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

  final String clubName;
  final String country;

  const _Club({
    required this.clubName,
    required this.country
    });


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
            Text( clubName, style: TextStyle( fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600,),),
            Text( country, style: TextStyle( fontSize: 16, color: Colors.white60, fontWeight: FontWeight.normal,),)
          ],
        ),
         
      ],
    );
  }
}

class _NamePlayer extends StatelessWidget {

  final String firstName;
  final String lastName;

  const _NamePlayer({
    required this.firstName, 
    required this.lastName
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text( this.firstName, style: TextStyle(fontSize: 26, color: Colors.white),),
        Text( this.lastName, style: TextStyle(fontSize: 42, color: Colors.white, fontWeight: FontWeight.w500),),
      ],
    );
  }
}

class _ImageBackground extends StatelessWidget {

  final String url;

  const _ImageBackground({required this.url});
 
  @override
  Widget build(BuildContext context) {
    return Container (  
      
      height: double.infinity,
      child: FadeInImage(
        placeholder: AssetImage('assets/placeholder.png'),
        image: NetworkImage( url ),
        fit: BoxFit.cover,
      ),
    );
  }
}