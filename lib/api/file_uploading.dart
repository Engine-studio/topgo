import 'dart:convert' show utf8, jsonDecode;

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:topgo/api/general.dart';

Future<PickedFile?> pickPhoto() async => await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

Future<String> uploadFile(PickedFile file) async {
  StreamedResponse response =
      await (http.MultipartRequest('POST', Uri.https(host, '/uploader/load'))
            ..fields['ext'] = basename(file.path).split('.').last
            ..files.add(
              http.MultipartFile.fromBytes('file', await file.readAsBytes()),
            ))
          .send();
  Response finalResponse = await http.Response.fromStream(response);
  if (response.statusCode == 200)
    return jsonDecode(utf8.decode(finalResponse.body.codeUnits))['file_path'];
  else
    throw Exception('Unable to connect to the server');
}

Future<String?> pickAndUploadFile() async {
  PickedFile? file = await pickPhoto();

  if (file == null) return Future.value(null);

  return await uploadFile(file);
}
