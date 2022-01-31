
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

void main() {

  test('Obtener todas las cartas', () async {

    final CardsApi api = CardFirebaseServices();

    final lista = await api.getAll();

    print(lista);

  });

  test('Obtener una sola carta del servicio', () async {

    final CardsApi api = CardFirebaseServices();

    final carta = await api.getById('-Ms6rTnfDCgGdegrZW_M');

    print(carta);

  });

  test('Guardar nueva carta en el servicio', () async {

    final CardsApi api = CardFirebaseServices();

    final newCard = Card(
      serie: Serie(idSerie: '9023', description: 'Serie A', publicationDate: DateTime.now()), 
      player: Player(idPlayer: 'adafa', firstName: 'Primer nombre',  lastName: 'Segundo nombre'), 
      rarities: Rarities(idRarities: 'asdfa', description: 'oro'), 
      team: Team(idTeam: 'adfad', teamName: 'Nombre de equipo'), 
      rolPlayer: RolePlayer(idRolePlayer: 'afr134', nameRole: 'nombre del rok'), 
      collection: [CollectionCard(idCollection: 'adfjae', description: 'Colecciond de la carta')]
    );

    final response = await api.save(newCard);

    print(response);
  });


  test( 'Borrar carta del servidor', () async {

    final CardsApi api = CardFirebaseServices();

    //todo: agregar id
    final response = await api.delete('-MukS3sGYIA6N99tMwJZ');

    print(response);

  });

  test( 'Actualizar carta del repositorio', () async {

    final cardToUpdate = Card(
      serie: Serie(idSerie: '9023', description: 'Serie A', publicationDate: DateTime.now()), 
      player: Player(idPlayer: 'adafa', firstName: 'Nuevo Jugador',  lastName: 'Segundo nombre'), 
      rarities: Rarities(idRarities: 'asdfa', description: 'oro'), 
      team: Team(idTeam: 'adfad', teamName: 'Nombre de equipo'), 
      rolPlayer: RolePlayer(idRolePlayer: 'afr134', nameRole: 'nombre del rok'), 
      collection: [CollectionCard(idCollection: 'adfjae', description: 'Colecciond de la carta')]
    );

    final CardsApi api = CardFirebaseServices();

    final response = await api.update( '-MukRwAJsR--9N4HqPu7', cardToUpdate );

  });
}