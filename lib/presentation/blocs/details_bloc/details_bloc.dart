import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:baseball_cards/controllers/cards_controller.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {

  final CardController _controller; 

  DetailsBloc( this._controller ) : super(DetailsInitial()) {
    
    on<GetDetails>( _onGetDetails );
  }

  void _onGetDetails(GetDetails event, Emitter<DetailsState> emit) async {

      emit(LoadingDetails());

      print('Se solicito la carta id: ${event.idCard}');

      final card = await this._controller.getCardById(event.idCard);

      print('Se obtuvo la carta ${card}');

      emit( DetailsInitial(
        serie: card.serie.description,
        collection: card.collection[0].description,
        rarity: card.rarities.description,
        team: card.team.teamName,
        firstNamePlayer: card.player.firstName,
        lastNamePlayer: card.player.lastName,
        rolePlayer: card.rolPlayer.nameRole,
        image: card.image
      ));

  }
}
