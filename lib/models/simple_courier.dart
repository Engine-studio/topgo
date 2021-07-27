import 'dart:convert' show jsonEncode;

import 'package:topgo/api/general.dart';
import 'package:topgo/functions/naive_time.dart';
import 'package:topgo/functions/phone_string.dart';
import 'package:topgo/models/order.dart';

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

enum OrderStatus {
  CourierFinding,
  CourierConfirmation,
  Cooking,
  ReadyForDelivery,
  Delivering,
  Delivered,
  FailureByCourier,
  FailureByRestaurant,
  Success
}

class SimpleCourier {
  int? id, movement;
  String? surname, name, patronymic, phoneSource, action, image, password;
  double? rating, cash, terminal, salary, x, y;
  bool? ordering, blocked, works;
  OrderStatus? orderStatus;
  WorkShift? session;

  SimpleCourier.create({
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.phoneSource,
    required this.password,
  })  : action = '',
        rating = 0 / 0;

  SimpleCourier.simple({required this.x, required this.y});

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
        works = json['is_in_session'],
        blocked = json['is_blocked'],
        cash = json['cash'] / 100,
        terminal = json['term'] / 100,
        salary = json['salary'] / 100,
        rating = double.parse(((json['current_rate_amount'] ?? 0) /
                (json['current_rate_count'] ?? 1))
            .toStringAsFixed(2)),
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

    orderStatus = (json['order_status'] != null)
        ? OrderStatus.values.firstWhere(
            (e) => e.toString() == 'OrderStatus.' + json['order_status'])
        : null;

    if (blocked!) {
      action = 'Заблокирован';
    } else {
      if (!works!) {
        action = 'Неактивен';
      } else {
        if (!ordering!) {
          action = 'Активен';
        } else {
          int id = json['order_id']!;
          action = [OrderStatus.Cooking].contains(orderStatus)
              ? 'Выполняет заказ №$id'
              : [OrderStatus.ReadyForDelivery].contains(orderStatus)
                  ? 'Забирает заказ №$id'
                  : 'Доставляет заказ №$id';
        }
      }
    }
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
