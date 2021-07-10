import 'dart:convert' show jsonEncode;

class Notification {
  String? title, message;

  Notification.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        message = json['message'];

  Notification.create({required this.title, required this.message});

  String get json => jsonEncode({"title": title, "message": message});
}
