import 'dart:convert' show utf8, jsonDecode;

import 'package:http/http.dart' as http;
import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/simple_courier.dart';

// TODO: Change route
Future<List<SimpleCourier>> getCouriers(BuildContext context) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
    );
    if (response.statusCode == 200)
      return jsonDecode(utf8.decode(response.body.codeUnits))
          .cast<List<Map<String, dynamic>>>()
          .map<SimpleCourier>((json) => SimpleCourier.fromJson(json))
          .toList();
    else if (response.statusCode == 401) if (!await logIn(context))
      throw Exception('Unable to log in');
    else
      throw Exception('Unable to connect to the server');
  }
}

// TODO: Change route
Future<void> newCourier(BuildContext context, SimpleCourier courier) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
      body: courier.json,
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
Future<bool> blockCourier(BuildContext context, SimpleCourier courier) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
      body: courier.jsonID,
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
Future<bool> unblockCourier(BuildContext context, SimpleCourier courier) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
      body: courier.jsonID,
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
Future<bool> deleteCourier(BuildContext context, SimpleCourier courier) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
      body: courier.jsonID,
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
Future<bool> discardCourier(
    BuildContext context, SimpleCourier courier, DiscardType type) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
      body: courier.jsonDiscard(type),
    );
    if (response.statusCode == 200)
      return Future.value(true);
    else if (response.statusCode == 401) if (!await logIn(context))
      throw Exception('Unable to log in');
    else
      throw Exception('Unable to connect to the server');
  }
}
