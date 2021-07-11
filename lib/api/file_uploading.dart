import 'dart:convert' show utf8, jsonDecode;
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:topgo/api/general.dart';

final ImagePicker _picker = ImagePicker();

Future<PickedFile?> pickPhoto() async {
  print('start picking');
  PickedFile? pickedFile = await _picker.getImage(
    source: ImageSource.gallery,
    imageQuality: 50,
  );
  print('pick photo');
  return pickedFile;
}

Future<String> uploadFile(File file) async {
  print('send');
  StreamedResponse response =
      await (http.MultipartRequest('POST', Uri.https(host, '/uploader/load'))
            ..fields['ext'] = basename(file.path).split('.').last
            ..files.add(
              http.MultipartFile.fromBytes('file', await file.readAsBytes()),
            ))
          .send();
  Response finalResponse = await http.Response.fromStream(response);
  print('got response');
  print(finalResponse.statusCode);
  if (finalResponse.statusCode == 200) {
    print(jsonDecode(utf8.decode(finalResponse.body.codeUnits))['file_path']);
    return jsonDecode(utf8.decode(finalResponse.body.codeUnits))['file_path'];
  } else
    throw Exception('Unable to connect to the server');
}

Future<String?> pickAndUploadFile() async {
  PickedFile? file = await pickPhoto();

  print('a');

  if (file == null) return Future.value(null);

  File foundFile = File(file.path);

  return await uploadFile(foundFile);
}
