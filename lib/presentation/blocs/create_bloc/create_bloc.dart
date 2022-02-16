import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:baseball_cards/models/card.dart' as bsCard;
import 'package:baseball_cards/data/repositories/collection_repo.dart';
import 'package:baseball_cards/data/repositories/raritie_repo.dart';
import 'package:baseball_cards/data/repositories/roles_player_repo.dart';
import 'package:baseball_cards/data/repositories/serie_repo.dart';
import 'package:baseball_cards/data/repositories/team_repo.dart';
import 'package:baseball_cards/services/firebase/collection_firebase_service.dart';
import 'package:baseball_cards/services/firebase/rarities_firebase_services.dart';
import 'package:baseball_cards/services/firebase/roles_player_firebase_service.dart';
import 'package:baseball_cards/services/firebase/serie_firebase_services.dart';
import 'package:baseball_cards/services/firebase/team_firebase_service.dart';
import 'package:baseball_cards/controllers/cards_controller.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {


  late CardController _controller;



  CreateBloc( CardController controller) : super(InitialCreateState()) {

    _controller = controller;

    on<LoadingOptions> ( _onLoadingOptions );

    on<SubmitedForm> ( _onSubmitedFormCreate );
  }


  FutureOr<void> _onLoadingOptions(LoadingOptions event, Emitter<CreateState> emit) async {

    final serieOptions = await SerieRepo.getInstance(SerieFirebaseService()).getAllSeries();
    final teamOptions = await TeamRepo.getInstance(TeamFirebaseService()).getAllTeams();
    final rarityOptions = await RaritieRepo.getInstance(RaritiesFirebaseServices()).getAllRarities();
    final rolePlayerOptions = await RolePlayerRepo.getInstance( RolesPlayerFirebaseServices()).getAllRoles();
    final collectionOptions = await CollectionRepo.getInstance( CollectionFirebaseService() ).getAllCollecions();


    LoadOptionsState loadOptionsState = LoadOptionsState(
      serieOptions: Map.fromIterables( serieOptions.map((e) => e.idSerie!).toList(), serieOptions.map((e) => e.description).toList()),
      teamOptions: Map.fromIterables( teamOptions.map((e) => e.idTeam!).toList(), teamOptions.map((e) => e.teamName).toList()),
      raritiesOptiones: Map.fromIterables( rarityOptions.map((e) => e.idRarities!).toList(), rarityOptions.map((e) => e.description).toList()),
      roleplayerOptions: Map.fromIterables( rolePlayerOptions.map((e) => e.idRolePlayer!).toList(), rolePlayerOptions.map((e) => e.nameRole).toList()),
      collectionOptiones: Map.fromIterables( collectionOptions.map((e) => e.idCollection!).toList(), collectionOptions.map((e) => e.description).toList()),
    );
    
    emit(loadOptionsState);

  }


  FutureOr<void> _onSubmitedFormCreate(SubmitedForm event, Emitter<CreateState> emit) async  {

    emit( LoadingFormState() );
    
    if ( event.lastName.isNotEmpty &&
      event.firstName.isNotEmpty &&
      event.idSerie.isNotEmpty &&
      event.idRarity.isNotEmpty &&
      event.idTeam.isNotEmpty &&
      event.idRolePlayer.isNotEmpty ) {

        print('Se envio el formulario correcto');

        final bsCard.Card newCard = await  _controller.createCard(
          event.lastName, 
          event.firstName, 
          event.idSerie, 
          event.idRarity, 
          event.idTeam, 
          event.idRolePlayer, 
          event.idsCollectionList
        );

        await _controller.saveNewCard(newCard);

        emit( SuccessProcessForm() );      
      }

      else {
        print('Fallo la carga del formulario');
        emit( FailureProcessForm(msj: 'No se pudo crear la carta') );
      }
  
    }
}
