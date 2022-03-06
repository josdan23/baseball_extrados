import 'package:baseball_cards/presentation/util.dart';
import 'package:baseball_cards/services/image_store_server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
 
import 'package:baseball_cards/controllers/cards_controller.dart';
import 'package:baseball_cards/presentation/blocs/create_bloc/create_bloc.dart';
import 'package:baseball_cards/presentation/widgets/button_widget.dart';
import 'package:baseball_cards/presentation/widgets/checkbox_widget.dart';
import 'package:baseball_cards/presentation/widgets/drop_down_menu_widget.dart';
import 'package:baseball_cards/presentation/widgets/image_card_widget.dart';
import 'package:baseball_cards/presentation/widgets/text_field_widget.dart';
import 'package:baseball_cards/services/firebase/card_firebase_services.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';

class CreateCardScreen extends StatelessWidget {

  static const String routeName = 'create_card';
  final CardController controller = CardController(CardFirebaseServices(), UserFirebaseService());

  CreateCardScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (context) => CreateBloc( controller ),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0,
            title: const Text( 'Nueva carta', style: TextStyle(fontSize: 16) ),
          ),
    
          body: BlocListener<CreateBloc, CreateState>(
            listener: (context, state) {

              print(state);

              if (state is SuccessProcessForm ){
                print('Creación de carta  exitosa');


                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Creado'))
                );

                BlocProvider.of<CreateBloc>(context).add(LoadingOptions());
              
              }
              if (state is FailureProcessForm ) {
                print('Error en la creación del carta');
               
                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No se pudo crear la carta'))
                );

                BlocProvider.of<CreateBloc>(context).add(LoadingOptions());
              }

            },
            child: _CreateCardForm(),
          )
        ),
    );
  }
}


class _CreateCardForm extends StatefulWidget {


  @override
  State<_CreateCardForm> createState() => _CreateCardFormState();
}

class _CreateCardFormState extends State<_CreateCardForm> {


  Map<String, String> teamOptions = {};
  Map<String, String> rarityOptions = {};
  Map<String, String> rolePlayerOptions = {};
  Map<String, String> serieOptions = {};
  Map<String, String> collectionOptions = {};


  String? pathImageSelected;

  @override
  Widget build(BuildContext context) {


    String? chosenPathImage = pathImageSelected;
    String chosenFirstName = '';
    String chosenLastName = '';
    String chosenIdTeam = '';
    String chosenIdRarity = '';
    String chosenIdRolePlayer = '';
    String chosenIdSerie = '';
    List<String> listOfChosenIdCollections = [];

    return BlocBuilder<CreateBloc, CreateState>(

      builder: (context, state) {

        
        if (state is InitialCreateState) {
          BlocProvider.of<CreateBloc>(context).add( LoadingOptions() );
        }

        if (state is LoadOptionsState) {

          this.teamOptions = state.teamOptions;
          this.rarityOptions = state.raritiesOptiones;
          this.rolePlayerOptions = state.roleplayerOptions;
          this.serieOptions = state.serieOptions;
          this.collectionOptions = state.collectionOptiones;


          return SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:  [
            
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [

                      ImageCardWidget(urlImage: pathImageSelected,),
                    
                      IconButton(icon: Icon(Icons.photo), onPressed: () async {

                        pathImageSelected = await Util.getPathImagePicked();
                        setState(() {});

                      },)
                    ],
                  ),
            
                  //* CAMPO PARA EL NOMBRE DEL JUGADOR
                  _TextField( 
                    label: 'Nombre de jugador',
                    onChanged: ( String value ) {
                      chosenFirstName = value;
                    },
                  ),
            
                  //* CAMPO PARA EL APELLIDO DEL JUGADOR
                  _TextField( 
                    label: 'Apellido del jugador',
                    onChanged: ( String value ) {
                      chosenLastName = value;
                    },
                  ),
    
            
                  //* LISTA DE TEAMS
                  const SizedBox(height: 16,),
                  _DropList(
                      label: 'Elegir equipo',
                      icon: const Icon(Icons.dashboard_customize_outlined),
                      options: teamOptions.values.toList(),
                      function: ( valueSelected ) {
                        
                        for (MapEntry e in teamOptions.entries) {
                          if (e.value == valueSelected) chosenIdTeam = e.key;
                        }

                      }
                    ),
    
    
                  //* LISTA DE ROLES
                  _DropList(
                    label: 'Elegir rol',
                    icon:  const Icon(Icons.dashboard_customize_outlined),
                    options:  rolePlayerOptions.values.toList(),
                    function: ( valueSelected ) {
    
                      for ( MapEntry e in rolePlayerOptions.entries ) {
                        if ( e.value == valueSelected ) chosenIdRolePlayer = e.key;
                      }
                    }
                  ),
            
    
    
                  //* LISTA DE RAREZAS
                  const SizedBox(height: 16,),
                  _DropList(
                    label: 'Elegir rareza',
                    icon: const Icon(Icons.dashboard_customize_outlined),
                    options: rarityOptions.values.toList(),
                    function: ( valueSelected ) {
                        
                      for ( MapEntry e in rarityOptions.entries ) {
                        if ( e.value == valueSelected ) chosenIdRarity = e.key;
                      }
    
                    }
                  ),
    
    
    
                  //* LISTA DE SERIES
                  const SizedBox(height: 16,),
                  _DropList(
                    label: 'Elegir serie',
                    icon: const Icon(Icons.dashboard_customize_outlined),
                    options: serieOptions.values.toList(),
                    function: ( valueSelected ) {
    
                      for (MapEntry e in serieOptions.entries ){
                        if (e.value == valueSelected) chosenIdSerie = e.key;
                      }
    
                    }
                  ),
    
    
                  //*  LISTA DE COLECCIONES
                  const SizedBox(height: 16,),
                  _CollectionList( 
                    collectionList: collectionOptions.values.toList(),
    
                    selected: ( valueSelected ){
                      
                      for ( MapEntry e in collectionOptions.entries) {
                        if ( e.value == valueSelected ) listOfChosenIdCollections.add(e.key);
                      }
    
                    },
    
                    unselected: ( valueUnselected ) {
                      
                      for (MapEntry e in collectionOptions.entries) {
                        if ( e.value == valueUnselected ) listOfChosenIdCollections.remove(e.key);
                      }
                      
                    },
                  ),
            
    
                  //* BOTÓN DE ENVIAR
                  const SizedBox(height: 24 ),
                  ButtonWidget(
                    text: 'Guardar',
                    colorBackground: Colors.amber, 
                    onPressed: (){
    
                      BlocProvider.of<CreateBloc>(context).add( 
                        SubmitedForm(
                          pathImage:  chosenPathImage, 
                          firstName: chosenFirstName, 
                          lastName: chosenLastName, 
                          idTeam: chosenIdTeam, 
                          idRarity: chosenIdRarity, 
                          idRolePlayer: chosenIdRolePlayer, 
                          idSerie: chosenIdSerie, 
                          idsCollectionList: listOfChosenIdCollections
                        )
                      );
    
                  }),
            
                ],
            
              ),
            ),
          )
        );
        }


        if ( state is SuccessProcessForm ) {
          print( 'se debería volver a cargar el formulario?');
        }

        if ( state is FailureProcessForm ) {
          print( 'Hubo un error en la creación de la carta');
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

  }
}

class _CollectionList extends StatelessWidget {

  final List<String> collectionList;
  final void Function( String ) selected;
  final void Function( String ) unselected;


  const _CollectionList({
    Key? key, 
    required this.collectionList,
    required this.selected,
    required this.unselected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          'Colecciones',
          style:  TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.w600, 
            color: Colors.black45),
        ),

        const SizedBox(height: 8,),

        Container(
           decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: collectionList.map((e) => 
              CheckboxWidget(title: e, onChanged: ( value ) {
                if (value )
                  this.selected( e );
                else
                  this.unselected( e );
                
              },)).toList()
          ),
        ),
      ],
    );
  }
}



class _TextField extends StatelessWidget {

  final String label;
  final Function(String) onChanged;

  const _TextField({ 
    Key? key, 
    required this.label, 
    required this.onChanged }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: 16,),

        Text(
          label, 
          style: const TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.w600, 
            color: Colors.black45
          ),
        ),

        const SizedBox(height: 8,),

        TextFieldWidget(
          text: label, 
          icon: Icons.person, 
          onChanged: onChanged
        ),
      ],
    );
  }
}


class _DropList extends StatelessWidget {

  final String label;
  final List<String> options;
  final Icon icon;
  final Function(String)? function;


  const _DropList({ 
    Key? key, 
    required this.label, 
    required this.options, 
    required this.icon,
    required this.function 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: 16),

        Text(
          label, 
          style: const TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.w600, 
            color: Colors.black45
          ),
        ),

        const SizedBox(height: 8,),

        DropDownMenuWidget(
          icon: icon ,
          listOfItems: options,
          function: this.function,
        ),
      ],
    );
  }
}

