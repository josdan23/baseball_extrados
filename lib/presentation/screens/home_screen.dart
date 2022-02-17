import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:baseball_cards/models/card.dart' as bsCard;
import 'package:baseball_cards/controllers/cards_controller.dart';
import 'package:baseball_cards/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:baseball_cards/presentation/widgets/action_button_widget.dart';
import 'package:baseball_cards/presentation/widgets/botton_nav_bar_widget.dart';
import 'package:baseball_cards/presentation/widgets/item_card_swiper.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';
import 'package:baseball_cards/services/firebase/card_firebase_services.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Bloc bloc;

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
            ),
            actions: [

              ActionButton(
                icon: Icons.search, 
                onPresss: (){ 
                  print('buscar');
                }
              ),

              ActionButton(
                icon: Icons.add,
                onPresss: () {
                  Navigator.of(context).pushNamed('create_card').then( ( _ ) {
                    
                    refresh(context);

                  });

                },
              ),

            ],
          ),
    
          bottomNavigationBar: const BottonNavBarWidget(index: 0),
    
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {

              
              if( state is HomeInitialState ){
                bloc = BlocProvider.of<HomeBloc>(context);
                bloc.add(RequestCards());
              }

              if( state is LoadingCardsState ) {

                return Container(
                  // height: MediaQuery.of(context).size.height * 0.8,
                  width: double.infinity,
                  child: const Center(
                    child: Image(image: AssetImage('assets/baseball_loading.gif')),
                  ),
                );
              }

              if (state is LoadedCardsState) {
                return Column(
                  children: [
                    const _FilterChoiceChips(),
                    Flexible(child: _CardSwipper(cardsList: state.cards)),
                  ],
                );
              }
             
              return Container();

            },
          ),
        ),
    );
  }

  void refresh(BuildContext context) {

    bloc.add(RequestCards());


  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _FilterChoiceChips extends StatelessWidget {

  const _FilterChoiceChips({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row( 
        children:  [
          ChoiceChip(label: Text('Todas'), selected: true, onSelected: ( bool value ) {
            print('presionado');
          },),
          ChoiceChip(label: Text('Oro'), selected: false),
          ChoiceChip(label: Text('Plata'), selected: false),
        ],
      ),
    );
  }
}




class _CardSwipper extends StatefulWidget {

  List cardsList = [];

  _CardSwipper({Key? key, required this.cardsList}) : super(key: key);

  @override
  State<_CardSwipper> createState() => _CardSwipperState();
}

class _CardSwipperState extends State<_CardSwipper> {

  @override
  Widget build(BuildContext context) {


    return Swiper(
      itemCount: widget.cardsList.length,
      viewportFraction: 0.8,
      scale: 0.9,
      loop: false,
      indicatorLayout: PageIndicatorLayout.WARM,
      itemBuilder: (BuildContext context,int index) {

        return CardItem(
          card: widget.cardsList[index],
          onTap: () {

            bsCard.Card card = widget.cardsList[index];

            Navigator.of(context).pushNamed('details', arguments: { 'idCard': card.idCard } ).then((value) {


              BlocProvider.of<HomeBloc>(context).add(RequestCards());

            });
            
          },
        );
      }
    );
  }
}