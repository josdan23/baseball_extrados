
import 'package:flutter_test/flutter_test.dart';

import 'package:baseball_cards/controllers/cards_controller.dart';
import 'package:baseball_cards/services/firebase/card_firebase_services.dart';

void main() {
  test('cards controller ...', () async {
    
    final CardController controller = CardController(CardFirebaseServices());

    final cardList = await controller.getAllCards();

    cardList.forEach( (element) {

      print(element.image);

    });
 
  });

}