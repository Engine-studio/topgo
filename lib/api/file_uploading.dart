import 'dart:convert' show utf8, jsonDecode;
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:topgo/api/general.dart';
import 'package:topgo/models/user.dart';
import 'package:provider/provider.dart';

final ImagePicker _picker = ImagePicker();

Future<XFile?> pickPhoto() async {
  print('Start picking');

  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  print('Photo picked');
  return image;
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

Future<String?> pickAndUploadFile(BuildContext context) async {
  XFile? _pickedFile = await pickPhoto();

  if (_pickedFile == null) return null;

  File foundFile = File(_pickedFile.path);

  User user = context.read<User>();

  String route = '/api/users/' +
      (user.role == Role.Courier
          ? 'couriers'
          : user.role == Role.Administrator
              ? 'admin'
              : 'curators') +
      '/update';

  String picture = await uploadFile(foundFile);

  await apiRequest(
    context: context,
    route: route,
    body: user.updatePhotoBody(picture),
  );

  return picture;
}
