
import 'package:flutter_test/flutter_test.dart';

import 'package:baseball_cards/controllers/cards_controller.dart';
import 'package:baseball_cards/services/firebase/card_firebase_services.dart';

void main() {
  test('cards controller ...', () async {
    
    final CardController controller = CardController(CardFirebaseServices());

    final lista = await controller.getAllCards();

    print(lista);
 
  });

  test('Obtener una sola carta del contrller', () async {

    final CardController controller = CardController( CardFirebaseServices());

    final carta = await controller.getCardById('-MukRwAJsR--9N4HqPu7');

    print(carta);

  });

}