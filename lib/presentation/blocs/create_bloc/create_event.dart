part of 'create_bloc.dart';

@immutable
abstract class CreateEvent {}


class LoadingOptions extends CreateEvent {}


class SubmitedForm extends CreateEvent{
  
    final String? pathImage;
    final String firstName;
    final String lastName;
    final String idTeam;
    final String idRarity;
    final String idRolePlayer;
    final String idSerie;
    final List<String> idsCollectionList;

  SubmitedForm({
    required this.pathImage, 
    required this.firstName, 
    required this.lastName, 
    required this.idTeam, 
    required this.idRarity,
    required this.idRolePlayer, 
    required this.idSerie, 
    required this.idsCollectionList
  });



}