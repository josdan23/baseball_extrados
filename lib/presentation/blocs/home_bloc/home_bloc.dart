import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:baseball_cards/controllers/cards_controller.dart';
import 'package:baseball_cards/models/card.dart' as bscard;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final CardController controller;

  HomeBloc(this.controller) : super(HomeInitial()) {

    on<RequestCards>( _onRequestCards );
  }

  _onRequestCards(RequestCards event, Emitter<HomeState> emit) async {

    emit( LoadingCards());
    
    final List<bscard.Card> listOfCards = await controller.getAllCards();


    print('CANTIDAD DE CARTAS = ${listOfCards.length}' );

    emit( HomeInitial( listOfCards ));

  }
}
