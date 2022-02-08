part of 'details_bloc.dart';

@immutable
abstract class DetailsState {}


class DetailsInitial extends DetailsState{}

class LoadedDetails extends DetailsState {
  
  final String? serie;
  final String? publicationDate;
  final List<String>? collection; 
  final String? rarity;

  final String? team;
  final String? firstNamePlayer;
  final String? lastNamePlayer;

  final String? rolePlayer;
  final String? image;

  LoadedDetails({
    this.serie, 
    this.publicationDate,
    this.collection, 
    this.rarity, 
    this.team, 
    this.firstNamePlayer, 
    this.lastNamePlayer, 
    this.rolePlayer,
    this.image
  });

  get fullName => '${this.lastNamePlayer} ${this.firstNamePlayer}';

}


class LoadingDetails extends DetailsState{}