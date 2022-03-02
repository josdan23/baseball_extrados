import 'package:baseball_cards/data/repositoriesV2/player_repo_impl.dart';
import 'package:baseball_cards/data/repositoriesV2/repository.dart';
import 'package:baseball_cards/services/firebase_service.dart';
import 'package:baseball_cards/services/mappers/mapper_for_firebase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('repositoryV2 ...', () async {

    final Repository repo = PlayerRepoImpl.getInstance(FirebaseService(pathResource: 'players'), MappersForFirebase());

    final lista = await repo.loadAll();

    print(lista);


  });
}