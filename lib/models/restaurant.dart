import 'dart:convert' show jsonEncode;

import 'package:topgo/functions/naive_time.dart';

class Restaurant {
  int? id;
  double? x, y;
  String? name, address, phone, password, email;
  List<List<int>>? open, close;

  static List<List<int>>? castJson(dynamic j) {
    if (j == null) return [];
    return [parseNaiveTime(j.first)!];
  }

  Restaurant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        address = json['address'],
        open = castJson(json['working_from']),
        close = castJson(json['working_till']),
        phone = json['phone'],
        x = json['location_lat'] ?? 0,
        y = json['location_lng'] ?? 0;

  Restaurant.simple({required this.x, required this.y});

  Restaurant.create({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.password,
    required this.open,
    required this.close,
    required this.x,
    required this.y,
  });

  String get json => jsonEncode({
        "name": name!,
        "address": address!,
        "lat": x!,
        "lng": y!,
        "phone": phone!,
        "email": email!,
        "password": password!,
        "working_from": open!.map((time) => toNaiveTime(time)).toList(),
        "working_till": close!.map((time) => toNaiveTime(time)).toList(),
      });

  String get jsonID => jsonEncode({"id": id!});
}
