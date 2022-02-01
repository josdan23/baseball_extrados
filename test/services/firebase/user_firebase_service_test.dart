
import 'package:baseball_cards/models/user.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';
import 'package:baseball_cards/services/users_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final UserApi api = UserFirebaseService();


  test('DEBE_INCREMENTAR_EN_1_LA_CANTIDAD_DE_USUARIOS_GUARDADOS_AL_CREAR_UN_NUEVO_USUARIO',() async {

    final allUsers =  await api.getAll();

    final User newUser = User(
      role    : 'collector',
      mail    : 'probando mail', 
      password: 'pass1234', 
      username: 'nuevoUsuario'
    );

    await api.save(newUser);

    final allUserWithNewUserSaved = await api.getAll();

    assert( allUsers.length < allUserWithNewUserSaved.length);
  });



  test('BORRAR_USUARIO_POR_ID', () async {

    final User newUser = User(
      role    : 'collector',
      mail    : 'probando mail', 
      password: 'pass1234', 
      username: 'nuevoUsuario'
    );

    final userSavedForDelete = await api.save(newUser);

    final allUsersAfterSaveNewUser = await api.getAll();

    await api.delete( userSavedForDelete.id! );

    final allUserAfterDeleteNewUser = await api.getAll();

    assert (allUserAfterDeleteNewUser.length < allUsersAfterSaveNewUser.length);

  });

  test('GUARDAR_USUARIO', () async {

    final UserApi api = UserFirebaseService();

    final User user = User(
      role    : 'collector',
      mail    : 'probando mail', 
      password: 'pass1234', 
      username: 'nuevoUsuario'
    );

    final userSaved = await api.save(user);
    
    print(userSaved.toString());
  });


  test('Listar todo los usuarios', () async  {

    final api = UserFirebaseService();

    final lista = await api.getAll();

    print(lista);

  });

  test('Obtener un usuairo por id', () async {

    final api = UserFirebaseService();

    final response = await api.getById('-Ms-p_Gz-MISJs0kS587');

    print(response);

  });


  test( 'Crear nuevo usuario por id', () async {

    final User user = User(
      role    : 'collector',
      mail    : 'nuevoUsuario@mail.com', 
      password: 'pass1234', 
      username: 'nuevoUsuario'
    );

  

    final api = UserFirebaseService();

    final response = await api.save( user );

    print( response ); 

  });


}