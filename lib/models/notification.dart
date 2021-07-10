import 'dart:convert' show jsonEncode;

class Notification {
  int? id;
  String? title, text;

  Notification.create({required this.title, required this.text});

  String get json => jsonEncode({"title": title, "text": text});
}
