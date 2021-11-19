import 'dart:convert' show utf8, jsonDecode, jsonEncode;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/snackbar.dart';

const host = "topgo.club";
const default_photo =
    'https://$host/static/2021/7/11/s_mP3ygZETXwYHPFH3MbwHvXzDFuAydczWJsIRVeV8E=.jpeg';

Map<String, String> jsonHeader(BuildContext context) =>
    {'Content-Type': 'application/json', 'jwt': context.read<User>().token!};

void dots({bool? end}) {
  if (end == true)
    for (int i = 3; i >= 0; i--) {
      print("." * i);
    }
  else
    for (int i = 1; i <= 3; i++) {
      print("." * i);
    }
}

/// Returns utf8 decoded codeUnits of response from server.
///
/// If headers is null uses jsonHeader with token.
/// Required route format - `/api/route_name`.
Future<String> apiRequest({
  required BuildContext context,
  required String route,
  Map<String, String>? headers,
  Object? body,
  bool detailed = true,
}) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, route),
      headers: headers ?? jsonHeader(context),
      body: body,
    );

    if (detailed) {
      dots();
      print('REQ:');
      print('route: $route');
      print('body: $body');
      print('RESP:');
      print('code: ${response.statusCode}');
      print('body: ${response.body}');
      dots(end: true);
    }

    int code = response.statusCode;
    String respBody = utf8.decode(response.body.codeUnits);

    if (code == 200)
      return respBody;
    else {
      String message = jsonDecode(respBody)['message'];

      if (code == 500 && message.contains('Signature')) {
        if (!await logInAgain(context)) throw Exception('Unable to log in');
      } else {
        ApiError(route: route, code: code, text: message).show(context);
        throw Exception('Unable to connect to the server');
      }
    }
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

  // print('');
  // print('route: loginFirst');
  // print('code: ${response.statusCode}');
  // print('body: ${response.body}');
  // print('');

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

final snackBar = SnackBar(
  content: Text('Yay! A SnackBar!'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),
);
