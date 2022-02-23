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
          print('listener: $state');
        },
        child: _FormEditCard(),
      ),
    );
  }
}



class _FormEditCard extends StatelessWidget {

  const _FormEditCard({
    Key? key,
  }) : super(key: key);

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
            return  SingleChildScrollView(
              
              child: Column(
                children: [
                  
                  NewTextFieldWidget(label: 'Nombre del jugador', initialValue: state.infoOfCard.firstName, onChanged: ( value ) {}),
                  NewTextFieldWidget(label: 'Apellido del jugador', initialValue: state.infoOfCard.lastName, onChanged: ( value ) {}),
            
                  DropListWidget(
                    label: 'Equipo', 
                    initialValue: state.options.teamOptions[state.infoOfCard.idTeam],
                    options: state.options.teamOptions.values.toList(), 
                    icon: const Icon(Icons.list), 
                    function: ( value ) {}
                  ),
            
                  DropListWidget(
                    label: 'Rol', 
                    initialValue: state.options.rolOptions[state.infoOfCard.idRol],
                    options: state.options.rolOptions.values.toList(), 
                    icon: const Icon(Icons.list), 
                    function: ( value ) {}
                  ),
            
                  DropListWidget(
                    label: 'Rareza', 
                    initialValue: state.options.rarityOptions[ state.infoOfCard.idRarity ],
                    options: state.options.rarityOptions.values.toList(), 
                    icon:const  Icon(Icons.list), 
                    function: ( value ) {}
                  ),
            
                  DropListWidget(
                    label: 'Serie', 
                    initialValue: state.options.serieOptions[ state.infoOfCard.idSerie ],
                    options: state.options.serieOptions.values.toList(), 
                    icon: const Icon(Icons.list), 
                    function: ( value ) {}
                  ),
            
                  CheckboxGroupWidget(
                    collectionList: state.options.collectionOptions, 
                    selectedList: state.infoOfCard.listOfIdCollections,
                    selected: ( value ){}, 
                    unselected: ( value ){}
                  ),


                   ButtonWidget(
                    text: 'Guardar',
                    colorBackground: Colors.amber, 
                    onPressed: (){

                        
                    }
                  ),  
            
                ],
              ),
            );
          }


          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );

  }
}

