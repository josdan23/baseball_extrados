part of 'details_bloc.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {
  
  final String? serie;
  final String? collection; //FIXME: tiene que ser una lista
  final String? rarity;

  final String? team;
  final String? firstNamePlayer;
  final String? lastNamePlayer;

  final String? rolePlayer;
  final String? image;

  DetailsInitial({
    this.serie, 
    this.collection, 
    this.rarity, 
    this.team, 
    this.firstNamePlayer, 
    this.lastNamePlayer, 
    this.rolePlayer,
    this.image
  });

}


class LoadingDetails extends DetailsState{}