import 'dart:convert' show utf8, jsonDecode, jsonEncode;
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topgo/models/order.dart';
import 'package:topgo/models/report.dart';
import 'package:topgo/models/user.dart';

const host = "topgo.club";

Map<String, String> jsonHeader(BuildContext context) =>
    {'Content-Type': 'application/json', 'jwt': context.read<User>().token!};

// TODO: Change route
Future<User> firstLogIn(String? phone, String? password) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      body: jsonEncode({
        'phone': phone,
        'password': password,
      }),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      await prefs.setString('phone', phone!);
      await prefs.setString('password', password!);
      return User.fromJson(jsonDecode(utf8.decode(response.body.codeUnits))
          .cast<Map<String, dynamic>>());
    } else {
      await prefs.clear();
      return User();
    }
  }
}

// TODO: Implement valid logIn function
Future<bool> logIn(BuildContext context) async {
  http.Response _ = await http.post(Uri.https(host, '/api/login'));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (1 > 0) {
    List<String> data = context.read<User>().loginData;
    await prefs.setString('phone', data[0]);
    await prefs.setString('password', data[1]);
  } else {
    await prefs.clear();
  }
  sleep(Duration(seconds: 15));
  return Future.value(true);
}

// TODO: Change route
Future<List<Report>> getReports(BuildContext context) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
    );
    if (response.statusCode == 200)
      return jsonDecode(utf8.decode(response.body.codeUnits))
          .cast<List<Map<String, dynamic>>>()
          .map<Order>((json) => Order.fromJson(json))
          .toList();
    else if (response.statusCode == 401) if (!await logIn(context))
      throw Exception('Unable to log in');
    else
      throw Exception('Unable to connect to the server');
  }
}
