import 'dart:convert' show jsonEncode;

import 'package:topgo/api/general.dart';
import 'package:topgo/functions/phone_string.dart';

class SimpleCurator {
  int? id;
  String? surname, name, patronymic, phoneSource, image, password;

  SimpleCurator.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        surname = json['surname'],
        name = json['name'],
        patronymic = json['patronymic'],
        phoneSource = json['phone'],
        image = json['picture'];

  SimpleCurator.create({
    required this.surname,
    required this.name,
    required this.patronymic,
    required this.phoneSource,
    required this.password,
  });

  String get json => jsonEncode({
        "surname": surname,
        "name": name,
        "patronymic": patronymic,
        "phone": phoneSource,
        "password": password,
      });

  String get jsonID => jsonEncode({"id": id});
  String get fullName => '$surname $name $patronymic';
  String get phone => phoneString(phoneSource!);
  String get photo => image != null ? 'https://$host/${image!}' : default_photo;
}
