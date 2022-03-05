
import 'package:image_picker/image_picker.dart';

class Util {

  static Future<String?> getPathImagePicked( ) async {

    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery
    );

    if ( pickedFile != null ) {

      print( 'Tenemos imagen ${pickedFile.path}' );
      return pickedFile.path;

    } else {
      print('No se seleccionó nada');
      return null;
    }

  }


}