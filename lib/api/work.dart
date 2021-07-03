import 'dart:convert' show utf8, jsonDecode;

import 'package:http/http.dart' as http;
import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/simple_curator.dart';

// TODO: Change route
Future<void> startWorkShift(BuildContext context, WorkShift shift) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
      body: shift.json,
    );
    if (response.statusCode == 200)
      return;
    else if (response.statusCode == 401) if (!await logIn(context))
      throw Exception('Unable to log in');
    else
      throw Exception('Unable to connect to the server');
  }
}

// TODO: Change route
Future<void> stopWorkShift(BuildContext context) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
    );
    if (response.statusCode == 200)
      return;
    else if (response.statusCode == 401) if (!await logIn(context))
      throw Exception('Unable to log in');
    else
      throw Exception('Unable to connect to the server');
  }
}

// TODO: Change route
Future<SimpleCurator> callHelper(BuildContext context) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
    );
    if (response.statusCode == 200)
      return SimpleCurator.helperFromJson(
        jsonDecode(
          utf8.decode(response.body.codeUnits),
        ).cast<Map<String, dynamic>>(),
      );
    else if (response.statusCode == 401) if (!await logIn(context))
      throw Exception('Unable to log in');
    else
      throw Exception('Unable to connect to the server');
  }
}
