import 'package:baseball_cards/data/repositories/player_repo_imp.dart';
import 'package:baseball_cards/data/repositories/repository.dart';
import 'package:baseball_cards/models/player.dart';
import 'package:baseball_cards/services/firebase_service.dart';
import 'package:baseball_cards/services/mappers/mapper_for_firebase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  

  test( 'Consguier una player', () async {

    final Repository<Player> repo = PlayerRepoImpl.getInstance( 
      FirebaseService(pathResource: 'players'),
      MappersForFirebase());

      final response = await repo.load('-Mw79lc0a_tjsfqZIIFl');
      print(response);

      final response2 = await repo.load('-Mw79lc0a_tjsfqZIIFl');
      print('otra response: $response2');

  });

  test(' conseguir todos los players', () async {
    
    final Repository<Player> repo = PlayerRepoImpl.getInstance( FirebaseService(pathResource: 'players'), MappersForFirebase());

    final lista = await repo.loadAll();

    lista.forEach(print);

    final response2 = await repo.load('-Mw79lc0a_tjsfqZIIFl');
      print('otra response: $response2');
    
  });


  test(' Guardar un  players', () async {
    
    final Repository<Player> repo = PlayerRepoImpl.getInstance( FirebaseService(pathResource: 'players'), MappersForFirebase());

    final Player player = Player(firstName: 'Alexander', lastName: 'Jordan') ;

    final  respuesta = await repo.save( player );

    print(respuesta);

  });


  test('actualizar un player', () async {

    final Repository<Player> repo = PlayerRepoImpl.getInstance( FirebaseService(pathResource: 'players'), MappersForFirebase());

    final Player player = Player(firstName: 'Michael', lastName: 'NUEVA UPDATE') ;
    player.idPlayer = '-MwlOD-X1mHcm3BZOWij';

    final result = await repo.update('-MwlOD-X1mHcm3BZOWij', player);

    print(result);

  });

  test('Borrar un player ', () async {

    final Repository<Player> repo = PlayerRepoImpl.getInstance( FirebaseService(pathResource: 'players'), MappersForFirebase());

    await repo.remove('-Mwfq7yFcaxPgYKzDz25');


  });
}