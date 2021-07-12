import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/order.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/user.dart';

Future<List<Order>> getOrdersHistory(BuildContext context) async {
  String json = await apiRequest(
    context: context,
    route: '/api/ordering/get_orders_by_courier_id',
  );

  return jsonDecode(json)
      .cast<List<Map<String, dynamic>>>()
      .map<Order>((json) => Order.fromJson(json))
      .toList();
}

Future<List<Order>> getCurrentOrders(
  BuildContext context,
  int sessionId,
) async {
  String json = await apiRequest(
    context: context,
    route: '/api/ordering/get_orders_by_session_id',
    body: jsonEncode({'id': sessionId}),
  );

  return jsonDecode(json)
      .cast<List<Map<String, dynamic>>>()
      .map<Order>((json) => Order.fromJson(json))
      .toList();
}

Future<void> getNewOrder(
  BuildContext context,
  OrderRequest orderRequest,
) async {
  String json = await apiRequest(
    context: context,
    route: '/api/ordering/get_orders',
    body: orderRequest.json,
  );

  context.read<User>().courier!.ordersRequest.add(Order.fromJson(
        jsonDecode(json).cast<Map<String, dynamic>>(),
      ));

  context.read<User>().courier!.notify();
}

Future<void> acceptOrder(BuildContext context, Order order) async =>
    await apiRequest(
      context: context,
      route: '/api/ordering/take_order',
      body: order.jsonID,
    );

Future<void> declineOrder(BuildContext context, Order order) async =>
    await apiRequest(
      context: context,
      route: '/api/ordering/refuse_order',
      body: order.jsonID,
    );

// TODO: implement of order status checking
Future<void> pickOrder(BuildContext context, Order order) async =>
    await apiRequest(
      context: context,
      route: '/api/ordering/pick_order',
      body: order.jsonID,
    );

Future<void> deliverOrder(BuildContext context, Order order) async =>
    await apiRequest(
      context: context,
      route: '/api/ordering/set_delivered_order',
      body: order.jsonID,
    );
