part of 'edit_bloc.dart';

@immutable
abstract class EditEvent {}

class GetInfoAndOptionsEvent extends EditEvent{

  final String idCard;

  GetInfoAndOptionsEvent(this.idCard);

}


class SubmitFormUpdateEvent extends EditEvent {

  final String idCard;
  final String image;
  final String firstName;
  final String lastName;
  final String idTeam;
  final String idRol;
  final String idRarity;
  final String idSerie;
  final List<String> idCollectionList;

  SubmitFormUpdateEvent({
    required this.idCard, 
    required this.image, 
    required this.firstName, 
    required this.lastName, 
    required this.idTeam, 
    required this.idRol, 
    required this.idRarity, 
    required this.idSerie, 
    required this.idCollectionList
  });

}
