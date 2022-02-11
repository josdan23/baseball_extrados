 
import 'package:baseball_cards/controllers/cards_controller.dart';
import 'package:baseball_cards/presentation/blocs/create_bloc/create_bloc.dart';
import 'package:baseball_cards/presentation/widgets/action_button_widget.dart';
import 'package:baseball_cards/presentation/widgets/button_widget.dart';
import 'package:baseball_cards/presentation/widgets/checkbox_widget.dart';
import 'package:baseball_cards/presentation/widgets/drop_down_menu_widget.dart';
import 'package:baseball_cards/presentation/widgets/image_card_widget.dart';
import 'package:baseball_cards/presentation/widgets/text_field_widget.dart';
import 'package:baseball_cards/services/firebase/card_firebase_services.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCardScreen extends StatelessWidget {

  static const String routeName = 'create_card';
  
  const CreateCardScreen({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final CardController controller = CardController(CardFirebaseServices(), UserFirebaseService());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text( 'Nueva carta', style: TextStyle(fontSize: 16) ),
      ),

      body: BlocProvider(
        create: (context) => CreateBloc(controller),
        child: BlocListener<CreateBloc, CreateState>(
          listener: (context, state) {
            
           if (state is FormCreateState ) {

              if (!state.isFormSaved) {
                print(' No se pudo guardar la carta');
                // BlocProvider.of<CreateBloc>( context ).add(LoadingOptions());
              }

              else {
                print(' Carta guardada');
              }

            }

          },
          child: _CreateCardForm(),
        ),
      )
    );
  }
}

class _CreateCardForm extends StatefulWidget {

  const _CreateCardForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_CreateCardForm> createState() => _CreateCardFormState();

}

class _CreateCardFormState extends State<_CreateCardForm> {

  @override
  Widget build(BuildContext context) {

    String pathImage = ''; 
    String firstName = '';
    String lastName = '';
    String idTeam = '';
    String idRarity = '';
    String idRolePlayer = '';
    String idSerie = '';
    List<String> idsCollectionList = [];



    return BlocBuilder<CreateBloc, CreateState>(

      builder: (context, state) {

        if (state is InitialCreateState ){

          BlocProvider.of<CreateBloc>(context).add( LoadingOptions() );

        }

       

        if ( state is LoadOptionsState ) {

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
                        ImageCardWidget(urlImage: 'https://via.placeholder.com/200x200',),
                      
                        ActionButton(icon: Icons.image, onPresss: (){})
                      ],
                    ),
              
                    _TextField( 
                      label: 'Nombre de jugador',
                      onChanged: ( String value ) {
                        firstName = value;
                      },
                    ),
              
                    _TextField( 
                      label: 'Apellido del jugador',
                      onChanged: ( String value ) {
                        lastName = value;
                      },
                    ),
              
                    const SizedBox(height: 16,),
      
              
                    _DropList(
                        label: 'Elegir equipo',
                        icon: Icon(Icons.dashboard_customize_outlined),
                        options: state.teamOptions.map((e) => e.teamName).toList(),
                        function: ( value ) {
                          idTeam = state.teamOptions.firstWhere((element) => element.teamName == value).idTeam!;
                          
                        }
                      ),
      
                    _DropList(
                      label: 'Elegir rol',
                      icon:  const Icon(Icons.dashboard_customize_outlined),
                      options:  state.roleplayerOptions.map((e) => e.nameRole).toList(),
                      function: ( value ) {
                          idRolePlayer = state.roleplayerOptions.firstWhere((element) => element.nameRole == value).idRolePlayer!;
                        }
                    ),
              
                    const SizedBox(height: 16,),
                    _DropList(
                      label: 'Elegir rareza',
                      icon: Icon(Icons.dashboard_customize_outlined),
                      options: state.raritiesOptiones.map((e) => e.description).toList(),
                      function: ( value ) {
                          idRarity = state.serieOptions.firstWhere((element) => element.description == value).idSerie!;
                        }
                    ),

                    const SizedBox(height: 16,),
                    _DropList(
                      label: 'Elegir serie',
                      icon: Icon(Icons.dashboard_customize_outlined),
                      options: state.serieOptions.map((e) => e.description).toList(),
                      function: ( value ) {
                          idSerie = state.serieOptions.firstWhere((element) => element.description == value).idSerie!;
                        }
                    ),
              
                    const SizedBox(height: 16,),
                    _CollectionList( 
                      collectionList: state.collectionOptiones.map((e) => e.description).toList(),
                      selected: ( e ){
                        final String idCollection = state.collectionOptiones.firstWhere((element) => element.description == e).idCollection!;
                        print('$idCollection seleccionado!');
                        idsCollectionList.add( idCollection );
                      },
                      unselected: ( e ) {
                        final String idCollection = state.collectionOptiones.firstWhere((element) => element.description == e).idCollection!;
                        idsCollectionList.remove(idCollection);
                      },
                    ),
              
              
                    const SizedBox(height: 24 ),
                    ButtonWidget(
                      text: 'Guardar',
                      colorBackground: Colors.amber, 
                      onPressed: (){

                        //Enviar evento
                        BlocProvider.of<CreateBloc>(context).add( 
                          SubmitedForm(
                            pathImage: 'https://via.placeholder.com/200x200', 
                            firstName: firstName, 
                            lastName: lastName, 
                            idTeam: idTeam, 
                            idRarity: idRarity, 
                            idRolePlayer: idRolePlayer, 
                            idSerie: idSerie, 
                            idsCollectionList: idsCollectionList
                          )
                        );

                        print('Guardar');
                    }),
              
                  ],
              
                ),
              ),
            )
          );

        }


        return Container(
          child: Center(child: CircularProgressIndicator()),
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

