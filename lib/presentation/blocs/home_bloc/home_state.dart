
part of 'home_bloc.dart';


@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class LoadingCardsState extends HomeState {}

class LoadedCardsState extends HomeState {
  final List<bscard.Card> cards;

  LoadedCardsState( {required this.cards });
}
