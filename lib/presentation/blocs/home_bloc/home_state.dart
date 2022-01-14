
part of 'home_bloc.dart';


@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {

  final List<bscard.Card> cards;

  HomeInitial( [ this.cards = const [] ]);

}

class LoadingCards extends HomeState {}
