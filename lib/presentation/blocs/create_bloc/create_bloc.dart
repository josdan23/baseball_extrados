import 'dart:async';
import 'package:baseball_cards/data/repositories/collection_repo.dart';
import 'package:baseball_cards/data/repositories/raritie_repo.dart';
import 'package:baseball_cards/data/repositories/roles_player_repo.dart';
import 'package:baseball_cards/data/repositories/serie_repo.dart';
import 'package:baseball_cards/data/repositories/team_repo.dart';
import 'package:baseball_cards/models/collection_card.dart';
import 'package:baseball_cards/models/rarities.dart';
import 'package:baseball_cards/models/role_player.dart';
import 'package:baseball_cards/models/serie.dart';
import 'package:baseball_cards/models/team.dart';
import 'package:baseball_cards/services/firebase/collection_firebase_service.dart';
import 'package:baseball_cards/services/firebase/rarities_firebase_services.dart';
import 'package:baseball_cards/services/firebase/roles_player_firebase_service.dart';
import 'package:baseball_cards/services/firebase/serie_firebase_services.dart';
import 'package:baseball_cards/services/firebase/team_firebase_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:baseball_cards/models/card.dart';
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
      serieOptions: serieOptions,
      teamOptions: teamOptions,
      raritiesOptiones: rarityOptions,
      roleplayerOptions: rolePlayerOptions,
      collectionOptiones: collectionOptions
    );
    
    emit(loadOptionsState);

  }


  FutureOr<void> _onSubmitedFormCreate(SubmitedForm event, Emitter<CreateState> emit) async  {

    if ( event.lastName.isNotEmpty &&
      event.firstName.isNotEmpty &&
      event.idSerie.isNotEmpty &&
      event.idRarity.isNotEmpty &&
      event.idTeam.isNotEmpty &&
      event.idRolePlayer.isNotEmpty ) {


      emit( FormCreateState( isLoadingForm: true ));

      // final Card newCard = await  _controller.createCard(
      //   event.lastName, 
      //   event.firstName, 
      //   event.idSerie, 
      //   event.idRarity, 
      //   event.idTeam, 
      //   event.idRolePlayer, 
      //   event.idsCollectionList
      // );

      // await _controller.saveNewCard(newCard);

      emit( FormCreateState(isFormSaved: true));

    }

    emit( FormCreateState(isFormSaved: false));
    emit( InitialCreateState());
 
    }
}
