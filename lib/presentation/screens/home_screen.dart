import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:baseball_cards/controllers/cards_controller.dart';
import 'package:baseball_cards/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:baseball_cards/presentation/widgets/botton_nav_bar_widget.dart';
import 'package:baseball_cards/presentation/widgets/item_card_swiper.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';
import 'package:baseball_cards/services/firebase/card_firebase_services.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final CardController controller = CardController( CardFirebaseServices(), UserFirebaseService() );

    return  BlocProvider(
      create: (context) => HomeBloc(controller),
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
            )
          ),
    
          bottomNavigationBar: const BottonNavBarWidget(),
    
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {

              
              if( state is HomeInitialState )
                BlocProvider.of<HomeBloc>(context).add(RequestCards());

              if( state is LoadingCardsState ) {

                return Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: double.infinity,
                  child: const Center(
                    child: Image(image: AssetImage('assets/baseball_loading.gif')),
                  ),
                );
              }

              if (state is LoadedCardsState)
                return _CardSwipper(cardsList: state.cards);
             
              return Container();

              
            },
          ),
        ),
    );
  
  }

}

class _CardSwipper extends StatelessWidget {

  final List cardsList;

  const _CardSwipper({Key? key, required this.cardsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.red,
      child: Swiper(
        itemCount: cardsList.length,
        viewportFraction: 0.8,
        scale: 0.9,
        loop: false,
        itemBuilder: (BuildContext context,int index) {
          return CardItem(
            card: cardsList[index],
            onTap: () {

              print(' Se presiona una carta id = ${cardsList[index]}');
              // Navigator.of(context).pushNamed('detail', id);
              
            },
          );
        }
      ),
    );
  }

}