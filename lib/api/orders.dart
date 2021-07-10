import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/order.dart';

// TODO: Change route
Future<List<Order>> getOrdersHistory(BuildContext context) async {
  String json = await apiRequest(context: context, route: '/api/shit');

  return jsonDecode(json)
      .cast<List<Map<String, dynamic>>>()
      .map<Order>((json) => Order.historyFromJson(json))
      .toList();
}

// TODO: Change route
Future<List<Order>> getCurrentOrders(BuildContext context) async {
  String json = await apiRequest(context: context, route: '/api/shit');

  return jsonDecode(json)
      .cast<List<Map<String, dynamic>>>()
      .map<Order>((json) => Order.fromJson(json))
      .toList();
}

// TODO: Change route
Future<Order> getNewOrders(BuildContext context, int count) async {
  String json = await apiRequest(
    context: context,
    route: '/api/shit',
    body: jsonEncode({'count': count}),
  );

  return Order.fromJson(
    jsonDecode(json).cast<Map<String, dynamic>>(),
  );
}

// TODO: Change route
Future<bool> acceptOrder(BuildContext context, Order order) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: order.jsonID,
  );

  return Future.value(true);
}

// TODO: Change route
Future<void> declineOrder(BuildContext context, Order order) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: order.jsonID,
  );
}

// TODO: Change route
Future<void> getOrder(BuildContext context, Order order) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: order.jsonID,
  );
}

// TODO: Change route
Future<void> deliverOrder(BuildContext context, Order order) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: order.jsonID,
  );
}
