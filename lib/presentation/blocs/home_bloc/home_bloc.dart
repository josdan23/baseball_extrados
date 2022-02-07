import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:baseball_cards/controllers/cards_controller.dart';
import 'package:baseball_cards/models/card.dart' as bscard;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final CardController controller;


  HomeBloc(this.controller) : super(HomeInitialState()) {

    on<RequestCards>( _onRequestCards );
  }


  _onRequestCards(RequestCards event, Emitter<HomeState> emit) async {

    print('solicitando cartas');

    emit( LoadingCardsState());
    
    final List<bscard.Card> listOfCards = await controller.getAllCards();

    emit( LoadedCardsState( cards: listOfCards ));

  }
}
