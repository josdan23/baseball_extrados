import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:baseball_cards/controllers/cards_controller.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {

  final CardController _controller; 

  DetailsBloc( this._controller ) : super(DetailsInitial()) {
    
    on<GetDetails>( _onGetDetails );
    on<DeleteCardEvent>( _onDeleteCard ); 

  }

  void _onGetDetails(GetDetails event, Emitter<DetailsState> emit) async {

      emit(LoadingDetails());

      print('Se solicito la carta id: ${event.idCard}');

      final card = await this._controller.getCardById(event.idCard);

      print('Se obtuvo la carta ${card}');

     
      List<String> listCollection = card.collection.map((e) {
        return e.description;
      },).toList();

      emit( LoadedDetails(
        serie: card.serie.description,
        publicationDate: dateInFormatResumed(card.serie.publicationDate),
        collection: listCollection,
        rarity: card.rarities.description,
        team: card.team.teamName,
        firstNamePlayer: card.player.firstName,
        lastNamePlayer: card.player.lastName,
        rolePlayer: card.rolPlayer.nameRole,
        image: card.image
      ));
  }

  FutureOr<void> _onDeleteCard(DeleteCardEvent event, Emitter<DetailsState> emit) {

    print('Se queire borrar la carta ');

    _controller.deleteCard( event.idCard );

    emit( DeletedCard() );

  }
}


String dateInFormatResumed( DateTime dateTime) {

  return '${dateTime.year}-${dateTime.month}-${dateTime.day}';

}
