part of 'create_bloc.dart';


abstract class CreateState {}

class InitialCreateState extends CreateState {}


class FormCreateState extends CreateState {

  bool isLoadingForm;
  bool isFormSaved;

  FormCreateState({
    this.isFormSaved = false,
    this.isLoadingForm = false
  });

}



class LoadOptionsState extends CreateState {

  List<Serie> serieOptions ;
  List<Rarities> raritiesOptiones;
  List<Team> teamOptions;
  List<RolePlayer> roleplayerOptions;
  List<CollectionCard> collectionOptiones;

  LoadOptionsState( { 
    required this.serieOptions,
    required this.raritiesOptiones,
    required this.teamOptions,
    required this.roleplayerOptions,
    required this.collectionOptiones,
  });


}

