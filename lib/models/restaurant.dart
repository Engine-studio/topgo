import 'dart:convert' show jsonEncode;

class Restaurant {
  int? id;
  double? x, y;
  String? name, address, phone, password;
  List<int>? open, close;
  Map<String, List<List<int>>>? schedule;

  Restaurant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        address = json['address'],
        open = json['open'],
        close = json['close'],
        phone = json['phone'],
        x = json['x'],
        y = json['y'];

  //TODO: remove useless
  Restaurant.create({
    required this.name,
    required this.address,
    required this.phone,
    required this.password,
    required this.schedule,
    this.x,
    this.y,
    this.open,
    this.close,
  });

  String get json => jsonEncode({
        "name": name,
        "address": address,
        "phone": phone,
        "password": password,
        "schedile": schedule,
      });

  String get jsonID => jsonEncode({"id": id});
}
