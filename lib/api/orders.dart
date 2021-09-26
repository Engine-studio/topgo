import 'dart:convert' show jsonDecode;

import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/order.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/user.dart';

Future<List<Order>> getOrdersHistory(BuildContext context) async {
  String json = await apiRequest(
    context: context,
    route: '/api/users/couriers/get_history',
  );

  context.read<User>().ordersHistory = jsonDecode(json)
      .cast<Map<String, dynamic>>()
      .map<Order>((json) => Order.fromJson(json))
      .toList();

  return Future.value([]);
}

Future<List<Order>> getCurrentOrders(BuildContext context) async {
  String json = await apiRequest(
    context: context,
    route: '/api/users/couriers/get_current',
  );

  List<Order> orders = jsonDecode(json)
      .cast<Map<String, dynamic>>()
      .map<Order>((json) => Order.fromJson(json))
      .toList();

  context.read<User>().ordersRequests = orders
      .where((order) => order.status == OrderStatus.CourierConfirmation)
      .toList();

  context.read<User>().orders = orders
      .where((order) => order.status != OrderStatus.CourierConfirmation)
      .toList();

  return Future.value([]);
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

  context.read<User>().courier!.ordersRequest.addAll(
        jsonDecode(json)
            .cast<Map<String, dynamic>>()
            .map<Order>((json) => Order.fromJson(json))
            .toList(),
      );

  context.read<User>().notify();
}

Future<bool> acceptOrder(BuildContext context, Order order) async {
  try {
    await apiRequest(
      context: context,
      route: '/api/ordering/take_order',
      body: order.jsonID,
    );
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> declineOrder(BuildContext context, Order order) async {
  try {
    await apiRequest(
      context: context,
      route: '/api/ordering/refuse_order',
      body: order.jsonID,
    );
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> pickOrder(BuildContext context, Order order) async {
  try {
    await apiRequest(
      context: context,
      route: '/api/ordering/pick_order',
      body: order.jsonID,
    );
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> deliverOrder(BuildContext context, Order order) async {
  try {
    await apiRequest(
      context: context,
      route: '/api/ordering/set_delivered_order',
      body: order.jsonID,
    );
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
