import 'package:baseball_cards/presentation/widgets/checkbox_group_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:baseball_cards/controllers/cards_controller.dart';
import 'package:baseball_cards/presentation/widgets/drop_list_widget.dart';
import 'package:baseball_cards/presentation/widgets/newtextfield_widget.dart';
import 'package:baseball_cards/presentation/blocs/edit_bloc/edit_bloc.dart';
import 'package:baseball_cards/services/firebase/card_firebase_services.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';

import '../widgets/button_widget.dart';
import '../widgets/image_card_widget.dart';


class EditCardScreen extends StatelessWidget {

  const EditCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => EditBloc( 
        CardController( CardFirebaseServices(), UserFirebaseService() ) 
      ),
      child: BlocListener<EditBloc, EditState>(
       
        listener: (context, state) {
          
          if ( state is SuccessUpdate ){
            print('listener: carta actualizada');

            ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('Carta actualizada!')));

            Navigator.of(context).pop();
          }

          if ( state is ErrorUpdate ) {

            print('listener: error al actualizar carta');

            ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('Error al actualizar carta!')));

            Navigator.of(context).pop();
          }

        },
        child: _FormEditCard(),
      ),
    );
  }
}



class _FormEditCard extends StatefulWidget {


  const _FormEditCard({
    Key? key,
  }) : super(key: key);

  @override
  State<_FormEditCard> createState() => _FormEditCardState();
}

class _FormEditCardState extends State<_FormEditCard> {
  late String chosenImage;
  late String chosenFirstName;
  late String chosenLastName;
  late String chosenIdTeam;
  late String chosenIdRol;
  late String chosenIdRarity;
  late String chosenIdSerie;
  late List<String> listOfChosenIdCollections;

  @override
  Widget build(BuildContext context) {

    final _arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final String _idCard = _arguments['idCard'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar carta'),
      ),

      body: BlocBuilder<EditBloc, EditState>(
        builder: (context, state) {
          
          if ( state is EditInitial ) {
            BlocProvider.of<EditBloc>(context).add( GetInfoAndOptionsEvent(_idCard) );

          }

          if ( state is LoadedOptionsState ) {

            _loadDefautlValues( state.infoOfCard );

            return  SingleChildScrollView(
              
              child: Column(
                children: [


                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [

                      const ImageCardWidget(urlImage: 'https://via.placeholder.com/200x200',),
                    
                      IconButton(icon: Icon(Icons.photo), onPressed: () {

                        chosenImage = 'https://via.placeholder.com/200x200';

                      },)
                    ],
                  ),

                  
                  NewTextFieldWidget(
                    label: 'Nombre del jugador', 
                    initialValue: state.infoOfCard.firstName, 
                    onChanged: ( value ) {
                      chosenFirstName = value;
                    }
                  ),
                  
                  NewTextFieldWidget(
                    label: 'Apellido del jugador', 
                    initialValue: state.infoOfCard.lastName, 
                    onChanged: ( value ) {
                      chosenLastName = value;
                    }
                  ),
            
                  DropListWidget(
                    label: 'Equipo', 
                    initialValue: state.options.teamOptions[state.infoOfCard.idTeam],
                    options: state.options.teamOptions.values.toList(), 
                    icon: const Icon(Icons.list), 
                    function: ( value ) {
                      
                      for (MapEntry e in state.options.teamOptions.entries) {
                        if ( e.value == value ) chosenIdTeam = e.key;
                      }
                    }
                  ),
            
                  DropListWidget(
                    label: 'Rol', 
                    initialValue: state.options.rolOptions[state.infoOfCard.idRol],
                    options: state.options.rolOptions.values.toList(), 
                    icon: const Icon(Icons.list), 
                    function: ( value ) {
                      for (MapEntry e in state.options.rolOptions.entries) {
                        if ( e.value == value ) chosenIdRol= e.key;
                      }
                    }
                  ),
            
                  DropListWidget(
                    label: 'Rareza', 
                    initialValue: state.options.rarityOptions[ state.infoOfCard.idRarity ],
                    options: state.options.rarityOptions.values.toList(), 
                    icon:const  Icon(Icons.list), 
                    function: ( value ) {
                      for (MapEntry e in state.options.rarityOptions.entries) {
                        if ( e.value == value ) chosenIdRarity= e.key;
                      }
                    }
                  ),
            
                  DropListWidget(
                    label: 'Serie', 
                    initialValue: state.options.serieOptions[ state.infoOfCard.idSerie ],
                    options: state.options.serieOptions.values.toList(), 
                    icon: const Icon(Icons.list), 
                    function: ( value ) {
                      for (MapEntry e in state.options.serieOptions.entries) {
                        if ( e.value == value ) chosenIdSerie= e.key;
                      }
                    }
                  ),
            
                  CheckboxGroupWidget(
                    collectionList: state.options.collectionOptions, 
                    selectedList: state.infoOfCard.listOfIdCollections,
                    selected: ( valueSelected ){
                      
                      for ( MapEntry e in state.options.collectionOptions.entries) {
                        if ( e.value == valueSelected ) listOfChosenIdCollections.add(e.key);
                      }
    
                    },
    
                    unselected: ( valueUnselected ) {
                      
                      for (MapEntry e in state.options.collectionOptions.entries) {
                        if ( e.value == valueUnselected ) listOfChosenIdCollections.remove(e.key);
                      }
                      
                    },
                  ),

                  ButtonWidget(
                    text: 'Guardar',
                    colorBackground: Colors.amber, 
                    onPressed: (){

                      BlocProvider.of<EditBloc>(context).add(
                        SubmitFormUpdateEvent(
                          image: chosenImage,
                          firstName: chosenFirstName,
                          lastName: chosenLastName,
                          idTeam: chosenIdTeam,
                          idRol: chosenIdRol,
                          idRarity: chosenIdRarity,
                          idSerie: chosenIdSerie,
                          idCollectionList: listOfChosenIdCollections
                        )
                      );
                        
                    }
                  ),  
            
                ],
              ),
            );
          }

          if ( state is SuccessUpdate ){
            print('Carta creada');
          }


          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );

  }

  void _loadDefautlValues(InfoOfCard infoOfCard) {

    chosenImage = infoOfCard.image;
    chosenFirstName = infoOfCard.firstName;
    chosenIdRol = infoOfCard.idRol;
    chosenLastName = infoOfCard.lastName;
    chosenIdTeam = infoOfCard.idTeam;
    chosenIdRarity = infoOfCard.idRarity;
    chosenIdSerie = infoOfCard.idSerie;
    listOfChosenIdCollections = infoOfCard.listOfIdCollections;

  }
}

