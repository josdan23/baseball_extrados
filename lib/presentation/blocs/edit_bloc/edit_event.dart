part of 'edit_bloc.dart';

@immutable
abstract class EditEvent {}

class GetInfoAndOptionsEvent extends EditEvent{

  final String idCard;

  GetInfoAndOptionsEvent(this.idCard);

}
