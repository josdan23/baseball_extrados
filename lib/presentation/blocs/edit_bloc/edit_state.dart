part of 'edit_bloc.dart';

@immutable
abstract class EditState {}

class EditInitial extends EditState {}


class LoadedOptionsState extends EditState{

  final InfoOfCard infoOfCard;
  final OptionsOfCard options;

  LoadedOptionsState({
    required this.infoOfCard,
    required this.options,

  });

} 

class InfoOfCard {
  final String firstName;
  final String lastName;
  final String idTeam;
  final String idRol;
  final String idRarity;
  final String idSerie;
  final List<String> listOfIdCollections;
  final String image;

  InfoOfCard({
    required this.firstName,
    required this.lastName,
    required this.idTeam,
    required this.idRol,
    required this.idRarity,
    required this.idSerie,
    required this.listOfIdCollections,
    required this.image,
  });
}

class OptionsOfCard {

  final Map<String, String> teamOptions;
  final Map<String, String> rolOptions;
  final Map<String, String> rarityOptions;
  final Map<String, String> serieOptions;
  final Map<String, String> collectionOptions;

  OptionsOfCard({
    required this.teamOptions,
    required this.rolOptions,
    required this.rarityOptions,
    required this.serieOptions,
    required this.collectionOptions
  });
  
}