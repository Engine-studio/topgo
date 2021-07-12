import 'dart:convert' show utf8, jsonDecode, jsonEncode;

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topgo/models/order.dart';
import 'package:topgo/models/report.dart';
import 'package:topgo/models/user.dart';

const host = "topgo.club";
const default_photo =
    'https://$host/static/2021/7/11/s_mP3ygZETXwYHPFH3MbwHvXzDFuAydczWJsIRVeV8E=.jpeg';

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
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200)
      return utf8.decode(response.body.codeUnits);
    else if (response.statusCode == 500 &&
        jsonDecode(utf8.decode(response.body.codeUnits))['message'] ==
            'ExpiredSignature') {
      if (!await logInAgain(context)) throw Exception('Unable to log in');
    } else
      throw Exception('Unable to connect to the server');
  }
}

Future<bool> logInAgain(BuildContext context) async {
  Map<String, dynamic> data = context.read<User>().loginData;
  String _json = await apiRequest(
    context: context,
    route: '/api/users/login',
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  Map<String, dynamic> json = jsonDecode(_json).cast<String, dynamic>();

  User user = User.fromJson(
    json,
    phoneSource: data['phone'],
    password: data['password'],
  );
  context.read<User>().copy(user);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (user.logined) {
    await prefs.setString('phone', user.loginData['phone']!);
    await prefs.setString('password', user.loginData['password']!);
    return Future.value(true);
  } else
    await prefs.clear();

  context.read<User>().copy(User());
  return Future.value(false);
}

Future<User> logInFirst(
  String? phone,
  String? password,
) async {
  print(phone);
  print(password);
  http.Response response = await http.post(
    Uri.https(host, '/api/users/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'phone': phone,
      'password': password,
    }),
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (response.statusCode == 200) {
    print('success');
    await prefs.setString('phone', phone!);
    await prefs.setString('password', password!);

    return User.fromJson(
      jsonDecode(
        utf8.decode(response.body.codeUnits),
      ),
      phoneSource: phone,
      password: password,
    );
  } else
    await prefs.clear();

  return User();
}

// TODO: ARTEM reports
Future<List<Report>> getReports(BuildContext context) async {
  String json = await apiRequest(context: context, route: '/api/shit');

  return jsonDecode(json)
      .cast<List<Map<String, dynamic>>>()
      .map<Order>((json) => Order.fromJson(json))
      .toList();
}
