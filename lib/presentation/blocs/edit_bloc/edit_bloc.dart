import 'dart:async';

import 'package:baseball_cards/controllers/cards_controller.dart';
import 'package:baseball_cards/models/card.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/collection_repo.dart';
import '../../../data/repositories/raritie_repo.dart';
import '../../../data/repositories/roles_player_repo.dart';
import '../../../data/repositories/serie_repo.dart';
import '../../../data/repositories/team_repo.dart';
import '../../../services/firebase/collection_firebase_service.dart';
import '../../../services/firebase/rarities_firebase_services.dart';
import '../../../services/firebase/roles_player_firebase_service.dart';
import '../../../services/firebase/serie_firebase_services.dart';
import '../../../services/firebase/team_firebase_service.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {

  final CardController _controller;

  EditBloc( this._controller ) : super(EditInitial()) {

    on<GetInfoAndOptionsEvent>( _onGetInfoAndOptions);
    on<SubmitFormUpdateEvent> ( _onSumitFormUpdateEvent );
  
  }


  void _onGetInfoAndOptions(GetInfoAndOptionsEvent event, Emitter<EditState> emit) async {

    final card = await _controller.getCardById( event.idCard );

    final InfoOfCard infoOfCard = _mapToInfoOfCard( card );

    final options = await _getOptionsOfCard();

    emit( LoadedOptionsState(infoOfCard: infoOfCard, options: options) );
    
  }


  InfoOfCard _mapToInfoOfCard( Card card ) {

    return InfoOfCard(
      firstName: card.player.firstName, 
      lastName: card.player.lastName, 
      idTeam: card.team.idTeam!, 
      idRol: card.rolPlayer.idRolePlayer!, 
      idRarity: card.rarities.idRarities!, 
      idSerie: card.serie.idSerie!, 
      listOfIdCollections: card.collection.map((e) => e.idCollection!).toList(), 
      image: card.image ?? 'https://via.placeholder.com/200x200' // FIXME: modificar esta parta para no harcodear la imagen
    );
  }

  Future<OptionsOfCard> _getOptionsOfCard( ) async {

    final serieOptions = await SerieRepo.getInstance(SerieFirebaseService()).getAllSeries();
    final teamOptions = await TeamRepo.getInstance(TeamFirebaseService()).getAllTeams();
    final rarityOptions = await RaritieRepo.getInstance(RaritiesFirebaseServices()).getAllRarities();
    final rolePlayerOptions = await RolePlayerRepo.getInstance( RolesPlayerFirebaseServices()).getAllRoles();
    final collectionOptions = await CollectionRepo.getInstance( CollectionFirebaseService() ).getAllCollecions();


    return OptionsOfCard(
      serieOptions: Map.fromIterables( serieOptions.map((e) => e.idSerie!).toList(), serieOptions.map((e) => e.description).toList()),
      teamOptions: Map.fromIterables( teamOptions.map((e) => e.idTeam!).toList(), teamOptions.map((e) => e.teamName).toList()),
      rarityOptions: Map.fromIterables( rarityOptions.map((e) => e.idRarities!).toList(), rarityOptions.map((e) => e.description).toList()),
      rolOptions: Map.fromIterables( rolePlayerOptions.map((e) => e.idRolePlayer!).toList(), rolePlayerOptions.map((e) => e.nameRole).toList()),
      collectionOptions: Map.fromIterables( collectionOptions.map((e) => e.idCollection!).toList(), collectionOptions.map((e) => e.description).toList()),
    );
  }

  FutureOr<void> _onSumitFormUpdateEvent(SubmitFormUpdateEvent event, Emitter<EditState> emit) async {

    emit( UpdatingInfo() );

    
    await _controller.updateCard(
      event.idCard,
      event.firstName,
      event.lastName,
      event.idTeam,
      event.idRol,
      event.idRarity,
      event.idSerie,
      event.idCollectionList,
    );

    emit( SuccessUpdate() );
    // emit( ErrorUpdate());    

  }
}


