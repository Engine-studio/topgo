import 'dart:convert' show jsonDecode;

import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/simple_courier.dart';

// TODO: Change route
Future<List<SimpleCourier>> getCouriers(BuildContext context) async {
  String json = await apiRequest(context: context, route: '/api/shit');
  return jsonDecode(json)
      .cast<List<Map<String, dynamic>>>()
      .map<SimpleCourier>((json) => SimpleCourier.fromJson(json))
      .toList();
}

// TODO: Change route
Future<void> newCourier(BuildContext context, SimpleCourier courier) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: courier.json,
  );
}

// TODO: Change route
Future<bool> blockCourier(BuildContext context, SimpleCourier courier) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: courier.jsonID,
  );

  return Future.value(true);
}

// TODO: Change route
Future<bool> unblockCourier(BuildContext context, SimpleCourier courier) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: courier.jsonID,
  );

  return Future.value(true);
}

// TODO: Change route
Future<bool> deleteCourier(BuildContext context, SimpleCourier courier) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: courier.jsonID,
  );

  return Future.value(true);
}

// TODO: Change route
Future<bool> discardCourier(
  BuildContext context,
  SimpleCourier courier,
  DiscardType type,
) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: courier.jsonDiscard(type),
  );

  return Future.value(true);
}
