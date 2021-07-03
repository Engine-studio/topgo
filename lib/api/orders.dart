import 'dart:convert' show utf8, jsonDecode;

import 'package:http/http.dart' as http;
import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/order.dart';

// TODO: Change route
Future<List<Order>> getOrdersHistory(BuildContext context) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
    );
    if (response.statusCode == 200)
      return jsonDecode(utf8.decode(response.body.codeUnits))
          .cast<List<Map<String, dynamic>>>()
          .map<Order>((json) => Order.historyFromJson(json))
          .toList();
    else if (response.statusCode == 401) if (!await logIn(context))
      throw Exception('Unable to log in');
    else
      throw Exception('Unable to connect to the server');
  }
}

// TODO: Change route
Future<List<Order>> getCurrentOrders(BuildContext context) async {
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

// TODO: Create getter for new order

// TODO: Change route
// TODO: Implement false value
Future<bool> acceptOrder(BuildContext context, Order order) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
      body: order.jsonID,
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
Future<void> declineOrder(BuildContext context, Order order) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
      body: order.jsonID,
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
Future<void> getOrder(BuildContext context, Order order) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
      body: order.jsonID,
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
Future<void> deliverOrder(BuildContext context, Order order) async {
  while (true) {
    http.Response response = await http.post(
      Uri.https(host, '/api/shit'),
      headers: jsonHeader(context),
      body: order.jsonID,
    );
    if (response.statusCode == 200)
      return;
    else if (response.statusCode == 401) if (!await logIn(context))
      throw Exception('Unable to log in');
    else
      throw Exception('Unable to connect to the server');
  }
}
