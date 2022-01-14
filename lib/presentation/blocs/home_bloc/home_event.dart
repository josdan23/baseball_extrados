part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class RequestCards extends HomeEvent {}

class PressCard extends HomeEvent {}
