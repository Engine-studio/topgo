import 'dart:convert' show jsonEncode;

import 'package:topgo/functions/phone_string.dart';

enum DiscardType {
  Full,
  Cash,
  Terminal,
  Salary,
}

class WorkShift {
  int? movement;
  List<int>? begin, end;
  bool? hasTerminal;

  WorkShift.create({
    required this.movement,
    required this.begin,
    required this.end,
    required this.hasTerminal,
  });

  WorkShift.fromJson(Map<String, dynamic> json)
      : movement = json['movement'],
        begin = json['begin'],
        end = json['end'],
        hasTerminal = json['hasTerminal'];

  String get json => jsonEncode({
        "movement": movement,
        "begin": begin,
        "end": end,
        "hasTerminal": hasTerminal,
      });
}

class SimpleCourier {
  int? id, movement;
  String? surname, name, patronymic, phoneSource, image, action, password;
  double? rating, cash, terminal, salary, x, y;
  bool? hasTerminal;

  SimpleCourier.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        surname = json['surname'],
        name = json['name'],
        patronymic = json['patronymic'],
        phoneSource = json['phone'],
        image = json['image'],
        action = json['action'],
        rating = json['rating'],
        cash = json['cash'],
        terminal = json['terminal'],
        salary = json['salary'],
        hasTerminal = json['hasTerminal'],
        movement = json['movement'],
        x = json['x'],
        y = json['y'];

  //TODO: remove useless
  SimpleCourier.create({
    required this.surname,
    required this.name,
    required this.patronymic,
    required this.phoneSource,
    required this.password,
    this.x,
    this.y,
    this.action,
    this.image,
    this.movement,
    this.rating,
  });

  String get json => jsonEncode({
        "surname": surname,
        "name": name,
        "patronymic": patronymic,
        "phone": phoneSource,
        "password": password,
      });

  String jsonDiscard(DiscardType type) => jsonEncode({
        "id": id,
        "cash": type == DiscardType.Full || type == DiscardType.Cash,
        "terminal": type == DiscardType.Full || type == DiscardType.Terminal,
        "salary": type == DiscardType.Full || type == DiscardType.Salary,
      });

  String get jsonID => jsonEncode({"id": id});
  String get fullName => '$surname $name $patronymic';
  String get phone => phoneString(phoneSource!);
}
