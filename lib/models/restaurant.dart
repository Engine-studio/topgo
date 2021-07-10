import 'dart:convert' show jsonEncode;

import 'package:topgo/functions/naive_time.dart';

class Restaurant {
  int? id;
  double? x, y;
  String? name, address, phone, password;
  List<List<int>>? open, close;

  Restaurant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        address = json['address'],
        open = json['working_from'],
        close = json['working_till'],
        phone = json['phone'],
        x = json['location_lat'] ?? 0,
        y = json['location_lng'] ?? 0;

  Restaurant.create({
    required this.name,
    required this.address,
    required this.phone,
    required this.password,
    required this.open,
    required this.close,
  });

  String get json => jsonEncode({
        "name": name!,
        "address": address!,
        "phone": phone!,
        "password": password!,
        "working_from": open!.map((time) => toNaiveTime(time)).toList(),
        "working_till": close!.map((time) => toNaiveTime(time)).toList(),
      });

  String get jsonID => jsonEncode({"id": id!});
}
