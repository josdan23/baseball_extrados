import 'package:baseball_cards/data/repositories/user_repo.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {


  test('Obtener todos los usuarios', () async {

    final repo = UserRepo.getInstance( UserFirebaseService());

    final lista = await repo.getAllUsers();

    print(lista);

  });


  test('Obtener un usuario por id', () async  {

    final repo = UserRepo.getInstance( UserFirebaseService( ) );

    final user = await repo.getUserById('-Ms-p_Gz-MISJs0kS587');

    print(user);

  });
}