import 'package:baseball_cards/data/repositories/user_repo.dart';
import 'package:baseball_cards/models/user.dart';
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

  test('Guardar nuevo usuario ', () async {

    final repo = UserRepo.getInstance( UserFirebaseService());
    
    final User newUser = User(
      mail: 'nuevomail@mail.com',
      password: 'nuevopass',
      username: 'nuevouser'
    );

    final user = await repo.save(newUser);

    print(user);

  });


  test('Actualizar usuario', () async {

    final repo = UserRepo.getInstance(UserFirebaseService());

    final User userToUpdate = User(
      mail: 'nuevomail@mail.com',
      password: 'updatepass',
      username: 'nuevouser'
    );

    userToUpdate.cardList.add('nuevo indice');
    userToUpdate.cardList.add('segunda carta');

    final response =   await repo.update('-MurecaAtzZs43ZJmW9J', userToUpdate);

    print(response);

  });
}