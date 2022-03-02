import 'package:baseball_cards/data/repositories/player_repo_imp.dart';
import 'package:baseball_cards/data/repositoriesV2/card_repo_impl.dart';
import 'package:baseball_cards/data/repositoriesV2/collection_repo_impl.dart';
import 'package:baseball_cards/data/repositoriesV2/player_repo_impl.dart';
import 'package:baseball_cards/data/repositoriesV2/rarity_repo_impl.dart';
import 'package:baseball_cards/data/repositoriesV2/repository.dart';
import 'package:baseball_cards/data/repositoriesV2/roles_player_repo_impl.dart';
import 'package:baseball_cards/data/repositoriesV2/serie_repo_impl.dart';
import 'package:baseball_cards/data/repositoriesV2/team_repo_impl.dart';
import 'package:baseball_cards/data/repositoriesV2/user_repo_imple.dart';
import 'package:baseball_cards/services/firebase_service.dart';
import 'package:baseball_cards/services/mappers/mapper_for_firebase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test( ' listar todas las cartas', () async {

    final repo = CardRepoImpl.getInstance(
      FirebaseService(pathResource: 'cards'), 
      MappersForFirebase());

      // final lista = await repo.load('-Ms6rTnfDCgGdegrZW_M');
      final lista = await repo.loadAll();

      print(lista);

  });

}