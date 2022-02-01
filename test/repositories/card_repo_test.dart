import 'package:baseball_cards/models/card.dart';
import 'package:baseball_cards/models/collection_card.dart';
import 'package:baseball_cards/models/player.dart';
import 'package:baseball_cards/models/rarities.dart';
import 'package:baseball_cards/models/role_player.dart';
import 'package:baseball_cards/models/serie.dart';
import 'package:baseball_cards/models/team.dart';
import 'package:baseball_cards/data/repositories/card_repo.dart';
import 'package:baseball_cards/services/firebase/card_firebase_services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
  final CardRepo repo = CardRepo.getInstance(CardFirebaseServices());

  test('Obtener todas las cartas', () async {
    
    final lista = await repo.getAllCards();

    print(lista);

  });


  test('Recuperar una carta del repo.', () async {

    final carta = await repo.getCardById('-MumBNvgLx8lJAF66oRy');

    print(carta);

  });

  test('Agregar nueva carta al repo.', () async {
   
    final newCard = Card(
      serie: Serie(idSerie: '9023', description: 'Serie A', publicationDate: DateTime.now()), 
      player: Player(idPlayer: 'adafa', firstName: 'Nuevo Jugador',  lastName: 'Segundo nombre'), 
      rarities: Rarities(idRarities: 'asdfa', description: 'oro'), 
      team: Team(idTeam: 'adfad', teamName: 'Nombre de equipo'), 
      rolPlayer: RolePlayer(idRolePlayer: 'afr134', nameRole: 'nombre del rok'), 
      collection: [CollectionCard(idCollection: 'adfjae', description: 'Colecciond de la carta')]
    );

    final response = await repo.save(newCard);

    print(response);
  });

  test('Borrar carta del repo', () async {

    final response = await repo.delete('-Mum2QMdz1qCB0bj3iTv');

    print(response);


  });


}