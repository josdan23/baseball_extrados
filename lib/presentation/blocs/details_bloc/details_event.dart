part of 'details_bloc.dart';

@immutable
abstract class DetailsEvent {}

class GetDetails extends DetailsEvent {
  final String idCard;

  GetDetails(this.idCard);

}
