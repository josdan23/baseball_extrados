part of 'details_bloc.dart';

@immutable
abstract class DetailsEvent {}

class GetDetails extends DetailsEvent {
  final String idCard;

  GetDetails(this.idCard);

}

class DeleteCardEvent extends DetailsEvent {

  final String idCard;

  DeleteCardEvent(this.idCard);

}


class EditCard extends DetailsEvent {

  final String idCard;

  EditCard( this.idCard );

}
