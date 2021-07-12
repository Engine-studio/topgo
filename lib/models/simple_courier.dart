import 'dart:convert' show jsonEncode;

import 'package:topgo/api/general.dart';
import 'package:topgo/functions/naive_time.dart';
import 'package:topgo/functions/phone_string.dart';

enum DiscardType {
  Full,
  Cash,
  Terminal,
  Salary,
}

class WorkShift {
  int? movement, id;
  List<int>? begin, end;
  bool? hasTerminal;

  WorkShift.create({
    required this.movement,
    required this.begin,
    required this.end,
    required this.hasTerminal,
  });

  WorkShift.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        movement = json['transport'] == 'Feet'
            ? 0
            : json['transport'] == 'Bicycle'
                ? 1
                : 2,
        begin = parseNaiveTime(json['start_time']),
        end = parseNaiveTime(json['end_time']),
        hasTerminal = json['has_terminal'];

  String get json => jsonEncode({
        "courier_id": -1,
        "transport": movement! == 0
            ? 'Feet'
            : movement! == 1
                ? 'Bicycle'
                : 'Car',
        "start_time": toNaiveTime(begin!),
        "end_time": toNaiveTime(end!),
        "has_terminal": hasTerminal!,
      });
}

class SimpleCourier {
  int? id, movement;
  String? surname, name, patronymic, phoneSource, action, image, password;
  double? rating, cash, terminal, salary, x, y;
  bool? ordering, blocked;
  WorkShift? session;

  SimpleCourier.create({
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.phoneSource,
    required this.password,
  })  : action = '',
        rating = 0 / 0;

  SimpleCourier.fromJson(
    Map<String, dynamic> json,
    List<Map<String, dynamic>> coords,
  )   : id = json['id'],
        surname = json['surname'],
        name = json['name'],
        patronymic = json['patronymic'],
        phoneSource = json['phone'],
        image = json['picture'],
        ordering = json['is_in_order'],
        blocked = json['is_blocked'],
        cash = json['cash'] / 100,
        terminal = json['term'] / 100,
        salary = json['salary'] / 100,
        rating = double.parse(
          (json['current_rate_count'] / json['current_rate_amount'])
              .toStringAsFixed(1),
        ),
        movement = json['transport'] == 'Feet'
            ? 0
            : json['transport'] == 'Bicycle'
                ? 1
                : 2 {
    for (Map<String, dynamic> c in coords) {
      if (c['courier_id'] == json['id']) {
        x = c['lat'];
        y = c['lng'];
      }
    }
    x = x ?? 0;
    y = y ?? 0;
    action = blocked! ? 'Заблокирован' : ''; //TODO: impl action
  }

  String get json => jsonEncode({
        "surname": surname!,
        "name": name!,
        "patronymic": patronymic!,
        "phone": phoneSource!,
        "password": password!,
      });

  String jsonDiscard(DiscardType type) => jsonEncode({
        "courier_id": id,
        "cash": type == DiscardType.Cash,
        "card": type == DiscardType.Terminal,
        "salary": type == DiscardType.Salary,
        "all": type == DiscardType.Full,
      });

  void discard(DiscardType type) {
    this.cash =
        type == DiscardType.Cash || type == DiscardType.Full ? 0 : this.cash;
    this.terminal = type == DiscardType.Terminal || type == DiscardType.Full
        ? 0
        : this.terminal;
    this.salary = type == DiscardType.Salary || type == DiscardType.Full
        ? 0
        : this.salary;
  }

  String get jsonID => jsonEncode({"id": id!});
  String get fullName => '${surname!} ${name!} ${patronymic!}';
  String get phone => phoneString(phoneSource!);
  String get photo => image != null ? 'https://$host/${image!}' : default_photo;
}
