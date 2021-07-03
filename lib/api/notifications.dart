import 'package:http/http.dart' as http;
import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/notification.dart' as topgo;

// TODO: Change route
Future<void> newNotification(
    BuildContext context, topgo.Notification notification) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
      body: notification.json,
    );
    if (response.statusCode == 200)
      return;
    else if (response.statusCode == 401) if (!await logIn(context))
      throw Exception('Unable to log in');
    else
      throw Exception('Unable to connect to the server');
  }
}
