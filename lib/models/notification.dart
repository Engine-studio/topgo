import 'dart:convert' show jsonEncode;

class Notification {
  String title, text;

  Notification({required this.title, required this.text});

  String get json => jsonEncode({"title": title, "text": text});
}
