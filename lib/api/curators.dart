import 'dart:convert' show utf8, jsonDecode;

import 'package:http/http.dart' as http;
import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/simple_curator.dart';

// TODO: Change route
Future<List<SimpleCurator>> getCurators(BuildContext context) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
    );
    if (response.statusCode == 200)
      return jsonDecode(utf8.decode(response.body.codeUnits))
          .cast<List<Map<String, dynamic>>>()
          .map<SimpleCurator>((json) => SimpleCurator.fromJson(json))
          .toList();
    else if (response.statusCode == 401) if (!await logIn(context))
      throw Exception('Unable to log in');
    else
      throw Exception('Unable to connect to the server');
  }
}

// TODO: Change route
Future<void> newCurator(BuildContext context, SimpleCurator curator) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
      body: curator.json,
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
Future<bool> blockCurator(BuildContext context, SimpleCurator curator) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
      body: curator.jsonID,
    );
    if (response.statusCode == 200)
      return Future.value(true);
    else if (response.statusCode == 401) if (!await logIn(context))
      throw Exception('Unable to log in');
    else
      throw Exception('Unable to connect to the server');
  }
}

// TODO: Change route
Future<bool> unblockCurator(BuildContext context, SimpleCurator curator) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
      body: curator.jsonID,
    );
    if (response.statusCode == 200)
      return Future.value(true);
    else if (response.statusCode == 401) if (!await logIn(context))
      throw Exception('Unable to log in');
    else
      throw Exception('Unable to connect to the server');
  }
}

// TODO: Change route
Future<bool> deleteCurator(BuildContext context, SimpleCurator curator) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
      body: curator.jsonID,
    );
    if (response.statusCode == 200)
      return Future.value(true);
    else if (response.statusCode == 401) if (!await logIn(context))
      throw Exception('Unable to log in');
    else
      throw Exception('Unable to connect to the server');
  }
}
