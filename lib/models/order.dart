import 'dart:convert' show jsonEncode;

class Order {
  int? id, total;
  String? from, to;
  double? appearance, behavior, sum, x, y;
  List<int>? start, stop;
  bool? withCash;

  Order.historyFromJson(Map<String, dynamic> json)
      : id = json['id'],
        from = json['address']['from'],
        to = json['address']['to'],
        total = json['time']['total'],
        start = json['time']['start'],
        stop = json['time']['stop'],
        sum = json['payment']['sum'],
        withCash = json['payment']['withCash'],
        appearance = json['points']['appearance'],
        behavior = json['points']['behavior'];

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        from = json['address']['from'],
        to = json['address']['to'],
        x = json['address']['x'],
        y = json['address']['y'],
        total = json['time'],
        sum = json['payment']['sum'],
        withCash = json['payment']['withCash'];

  String get jsonID => jsonEncode({"id": id});
}
