import 'dart:convert' show utf8, jsonDecode, jsonEncode;

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topgo/models/order.dart';
import 'package:topgo/models/report.dart';
import 'package:topgo/models/user.dart';

const host = "topgo.club";
const default_photo = '';

Map<String, String> jsonHeader(BuildContext context) =>
    {'Content-Type': 'application/json', 'jwt': context.read<User>().token!};

/// Returns utf8 decoded codeUnits of response from server.
///
/// If headers is null uses jsonHeader with token.
/// Required route format - `/api/route_name`.
Future<String> apiRequest({
  required BuildContext context,
  required String route,
  Map<String, String>? headers,
  Object? body,
}) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, route),
      headers: headers ?? jsonHeader(context),
      body: body,
    );
    if (response.statusCode == 200)
      return utf8.decode(response.body.codeUnits);
    else if (response.statusCode == 401) if (!await logIn(context))
      throw Exception('Unable to log in');
    else
      throw Exception('Unable to connect to the server');
  }
}

Future<dynamic> logIn(
  BuildContext? context, {
  String? phone,
  String? password,
}) async {
  if (phone != null && password != null) {
    http.Response response = await http.post(
      Uri.https(host, '/api/users/login'),
      body: jsonEncode({
        'phone': phone,
        'password': password,
      }),
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      await prefs.setString('phone', phone);
      await prefs.setString('password', password);
      return User.fromJson(
        jsonDecode(
          utf8.decode(response.body.codeUnits),
        ).cast<Map<String, dynamic>>(),
        phoneSource: phone,
        password: password,
      );
    } else
      await prefs.clear();

    return User();
  }

  String _json = await apiRequest(
    context: context!,
    route: '/api/users/login',
    headers: {},
    body: jsonEncode(context.read<User>().loginData),
  );

  Map<String, dynamic> json = jsonDecode(_json).cast<Map<String, dynamic>>();

  User user = User.fromJson(
    json,
    phoneSource: phone,
    password: password,
  );
  context.read<User>().copy(user);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (user.logined) {
    await prefs.setString('phone', user.loginData['phone']!);
    await prefs.setString('password', user.loginData['password']!);
    return Future.value(true);
  } else
    await prefs.clear();
  return Future.value(false);
}

// TODO: Change route
Future<List<Report>> getReports(BuildContext context) async {
  String json = await apiRequest(context: context, route: '/api/shit');

  return jsonDecode(json)
      .cast<List<Map<String, dynamic>>>()
      .map<Order>((json) => Order.fromJson(json))
      .toList();
}
