import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:baseball_cards/controllers/cards_controller.dart';
import 'package:baseball_cards/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:baseball_cards/presentation/widgets/item_card_swiper.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';
import 'package:baseball_cards/services/firebase/card_firebase_services.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final CardController controller = CardController( CardFirebaseServices(), UserFirebaseService() );

    return BlocProvider(
      create: (context) {
        final bloc = HomeBloc(controller);
        bloc.add(RequestCards());

        return bloc;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          //APPBAR  
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: false,
            elevation: 0,
            title: const Text(
              'Mi colección', 
              style: TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.bold,
                fontSize: 24,
              )
            ),
            actions: [
    
              //BUSCAR
              _SearchButton(),
              SizedBox(width: 4,),
              // PERFIL DE USUARIO
              _ProfileButton(),
              SizedBox(width: 16,),
            ],
          ),

          body: Center(
            child: Column(
              children: [
      
                _CardSwipper(),
      
              ],
            ),
          ),
        ),
    );
  }
}

class _SearchButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search, color: Colors.black),
      onPressed: (){

        //TODO: implementar el delegate de busqueda

      }, 
    );
  }
}

class _ProfileButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: CircleAvatar(
        child: Icon(Icons.person),
        backgroundColor: Colors.black12,
        foregroundColor: Colors.black,
      ),
      onPressed: (){

        //TODO: implementar perfil de usuario

      },
    );
  }
}



class _CardSwipper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeBloc, HomeState>(

      builder: (context, state) {
        
        if (state is HomeInitial) {
          
          final cardsList = state.cards;

          return Container(

            height: MediaQuery.of(context).size.height * 0.7,
            width: double.infinity,
            child: Swiper(
              itemCount: cardsList.length,
              viewportFraction: 0.8,
              scale: 0.9,
              loop: false,
              itemBuilder: (BuildContext context,int index) {
                return CardItem(
                  card: cardsList[index],
                  onTap: () {
                    print(' Se presiona una carta');
                  },
                );
              }
            ),
          );
        }

        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: double.infinity,
          child: const Center(
            child: Image(image: AssetImage('assets/baseball_loading.gif')),
          ),
        );

      },
    );
  }
}