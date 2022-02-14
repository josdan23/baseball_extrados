part of 'create_bloc.dart';


abstract class CreateState {}

class InitialCreateState extends CreateState {}

class LoadOptionsState extends CreateState {

  Map<String, String> serieOptions ;
  Map<String, String> raritiesOptiones;
  Map<String, String> teamOptions;
  Map<String, String> roleplayerOptions;
  Map<String, String> collectionOptiones;

  LoadOptionsState( { 
    required this.serieOptions,
    required this.raritiesOptiones,
    required this.teamOptions,
    required this.roleplayerOptions,
    required this.collectionOptiones,
  });

}

class LoadingFormState extends CreateState {}

class FailureProcessForm extends CreateState {
  String msj = '';

  FailureProcessForm({
    required this.msj
  });
}

class SuccessProcessForm extends CreateState {}