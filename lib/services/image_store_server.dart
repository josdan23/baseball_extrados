
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ImageStoreServer  {

  final String _endpoint = 'https://api.cloudinary.com/v1_1/dwb1t7qzs/image/upload?upload_preset=m5pyjftt';

  Future<String?> uploadImageToServer( String imagePath ) async {

    File? imageFile = getImageFile( imagePath );

    if (imageFile == null ) return null;



    final url = Uri.parse(_endpoint);

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imageFile.path);

    imageUploadRequest.files.add( file );

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream( streamResponse );

    final decodedData = json.decode( resp.body );
    print( decodedData );

    return decodedData['secure_url'];
  }

  File? getImageFile(String imagePath) {
    
    if (imagePath.contains('http')) return null;

    return File.fromUri( Uri(path: imagePath));
  }

}