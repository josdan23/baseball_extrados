import 'package:baseball_cards/presentation/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:baseball_cards/controllers/cards_controller.dart';
import 'package:baseball_cards/presentation/blocs/details_bloc/details_bloc.dart';
import 'package:baseball_cards/services/firebase/card_firebase_services.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';

class DetailsScreen extends StatelessWidget {

  final CardController controller = CardController(CardFirebaseServices(), UserFirebaseService());

  DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  
    return BlocProvider(
      create: (context) => DetailsBloc(controller),

      child: BlocListener<DetailsBloc, DetailsState>(

        listener: (context, state) {

            if (state is DeletedCard ){
              print('La carta se borro');
              Navigator.pop(context);
            }

        },
        child: _DetailsCard(),
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final _idCard = _arguments['idCard'];

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: <Widget>[

          ActionButton(
            icon: Icons.edit, 
            onPresss: (){
              print('CARTA PARA EDITAR');
            }
          ),

          ActionButton(
            icon: Icons.delete, 
            onPresss: () {
              BlocProvider.of<DetailsBloc>(context).add(DeleteCardEvent(_idCard));
            }
          ),


        ],
      ),

      body: BlocBuilder<DetailsBloc, DetailsState>(

        builder: (context, state) {


          if ( state is DetailsInitial){
            
            BlocProvider.of<DetailsBloc>(context).add( GetDetails(_idCard) );

            return const Center(
              child: CircularProgressIndicator()
            );

          }


          if ( state is LoadingDetails){
            return const Center(
              child: CircularProgressIndicator()
            );
          }

          if ( state is DeletedCard ) {
            // Navigator.of(context).pop();
            print('carta borrada');
          }

          if ( state is LoadedDetails ){

            return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
              
                      const SizedBox(height: 8),
              
                      // Imagen de la carta
                      _ImageCard(urlImage:  ( state.image == null || state.image == "") 
                      ? 'https://via.placeholder.com/200x200'
                      : state.image!),
              
                      const SizedBox(height: 28,),
              
              
                      //Nombre del jugador
                      Text( state.fullName , style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),),
              
                      const SizedBox(height: 12,),
                      //Info de la carta
                      _InfoCard(
                        date: state.publicationDate!,
                        rarity: state.rarity!,
                        serie: state.serie!,
                      ),
              
                      SizedBox(height: 24,),
              
                      _InfoPlayer(
                        rolPlayer: state.rolePlayer!,
                        teamPlayer: state.team!,
                      ),
              
                      SizedBox(height: 24),
              
          
                      _Collection( collectionList: state.collection!),

                      SizedBox(height: 24,)
              
                    ],
                  ),
                ),
              );
          }

          return Container();

        },
      ),

    );
  }
}

class _Collection extends StatelessWidget {

  final List<String> collectionList;

  const _Collection({
    Key? key, 
    required this.collectionList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (collectionList.length == 0) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('De la colección',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            
        SizedBox(height: 12),
            
        Wrap(
          children: creteWidgetList(collectionList)
        ),
      ],
    );
  }

  List<Widget> creteWidgetList( List<String> labelList ){

    return labelList.map<Widget>((e) => createItemCollection(e)).toList();

  }

  Widget createItemCollection(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(label: Text(text), backgroundColor: Colors.grey.shade200),
    );
  }
}

class _InfoPlayer extends StatelessWidget {

  final String rolPlayer;
  final String teamPlayer;

  const _InfoPlayer({
    Key? key, 
    required this.rolPlayer, 
    required this.teamPlayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        createItemInfoPlayer(this.rolPlayer, Icons.accessibility_new_outlined),

        SizedBox(width: 16,),

        createItemInfoPlayer(this.teamPlayer, Icons.perm_contact_cal_outlined)
      ],
    );
  }

  Container createItemInfoPlayer(String text, IconData iconData) {
    return Container(
        height: 140,
        width: 130,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                iconData,
                size: 48,
                color: Colors.grey.shade700,
              ),
              SizedBox(height: 12,),

              Text(text, style: TextStyle(fontSize: 15), textAlign: TextAlign.justify, maxLines: 2, overflow: TextOverflow.clip,
              )
            ],
          ),
        ),
      );
  }
}

class _InfoCard extends StatelessWidget {

  final String date;
  final String rarity;
  final String serie;

  const _InfoCard({
    Key? key, 
    required this.date, 
    required this.rarity, 
    required this.serie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _createNewItem(Icons.calendar_today_rounded, this.date),
        _createNewItem(Icons.grade_outlined, this.rarity),
        _createNewItem(Icons.qr_code_outlined, this.serie)
      ],
    );
  }

  Row _createNewItem(IconData iconData, String text) {
    return Row(
      children: [
        Icon( iconData, size: 18, color: Colors.grey.shade600,),
        const SizedBox(width: 8,),
        Text(text, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade600),),
        const SizedBox(width: 20,)
      ],
    );
  }
}

class _ImageCard extends StatelessWidget {

  final String urlImage;

  const _ImageCard({
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