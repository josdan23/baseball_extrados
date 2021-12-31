import 'package:baseball_cards/models/card.dart';
import 'package:baseball_cards/models/collection_card.dart';
import 'package:baseball_cards/models/player.dart';
import 'package:baseball_cards/models/rarities.dart';
import 'package:baseball_cards/models/role_player.dart';
import 'package:baseball_cards/models/serie.dart';
import 'package:baseball_cards/models/team.dart';
import 'package:baseball_cards/services/cards_api.dart';
import 'package:baseball_cards/services/firebase/card_firebase_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';

void main() {
 
  final CardsApi api = CardFirebaseServices();
  final Logger _logger = Logger();

  final Card cardToSave = Card(
      serie: Serie(description: 'S02', publicationDate: DateTime.now(), idSerie: '930ADFAD' ), 
      player: Player(idPlayer: 'ASD34', firstName: 'Daniel', lastName: 'yapura'), 
      rarities: Rarities(idRarities: 'j90AJDF9', description: 'gold'), 
      team: Team(idTeam: '900DFK3K', teamName: 'Boston RedSox'), 
      rolPlayer: RolePlayer(idRolePlayer: 'mOEMVDIW9', nameRole: 'pitcher'), 
      collection: [
        CollectionCard(idCollection: '90ASDF', description: 'MVP'),
        CollectionCard(idCollection: '9210', description: 'CHAMPIONS'),
      ]
    );

  test('LA_LISTA_DE_CARTAS_ES_MAYOR_A_CERO', () async {

    List<Card> cardList = await api.getAll();

    assert( cardList.isNotEmpty ); 

  });

  test('AL_GUARDAR_CARTA_SE_DEBE_OBTENER_LA_MISMA_CARTA_CON_ID', () async {

    final Card cardSaved = await api.save( cardToSave );

    _logger.wtf(cardSaved.toString());

    assert( cardSaved.idCard != null );

  });


  test('GUARDAR_CARTA_DEBE_INCREMENTAR_LA_CANTIDAD_DE_CARTAS_GUARDADAS', () async {

    final allCardsBeforeToSave = await api.getAll();

    await api.save(cardToSave);

    final allCardsAfterToSave = await api.getAll();

    assert( allCardsBeforeToSave.length < allCardsAfterToSave.length );

  });



  test( 'obtener una carta', () async {

    final id1 = '-MsAFvR_FJrZT-EZuS4X';
    final id2 = 'ASD354';


    await api.getById(id1);

  });

  test( 'mostrar todas las cartas', () async {

    await api.getAll();
  });

}