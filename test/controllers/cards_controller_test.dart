
import 'package:baseball_cards/data/repositories/user_repo.dart';
import 'package:baseball_cards/services/firebase/user_firebase_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:baseball_cards/controllers/cards_controller.dart';
import 'package:baseball_cards/services/firebase/card_firebase_services.dart';

void main() {
  test('cards controller ...', () async {
    
    final CardController controller = CardController(CardFirebaseServices(), UserFirebaseService());

    final lista = await controller.getAllCards();

    print(lista);
 
  });

  test('Obtener una sola carta del contrller', () async {

    final CardController controller = CardController( CardFirebaseServices(), UserFirebaseService());

    final carta = await controller.getCardById('-MukRwAJsR--9N4HqPu7');

    print(carta);

  });

  test('obtener cartas de un usuario ', () async  {

    final CardController controller = CardController( CardFirebaseServices(), UserFirebaseService());

    final allCards = await controller.getAllCards();

    final userRepo = UserRepo.getInstance(UserFirebaseService());

    final user = await userRepo.getUserById('-MurecaAtzZs43ZJmW9J');

    userRepo.userAuthenticated = user;

    final cartas = await  controller.getAllCardsByUser();

    print(cartas);

  });


  test('Intercambiar cartas', () async {

    final CardController controller = CardController( CardFirebaseServices(), UserFirebaseService());

    final allCards = await controller.getAllCards();

  
    final userRepo = UserRepo.getInstance(UserFirebaseService());

    final user = await userRepo.getUserById('-MurecaAtzZs43ZJmW9J');

    userRepo.userAuthenticated = user;

    await controller.exchangeCard('-Ms-p_Gz-MISJs0kS587', '-MukRwAJsR--9N4HqPu7');

    


  });

}