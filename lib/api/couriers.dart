import 'dart:convert' show jsonDecode;

import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/simple_courier.dart';

Future<List<SimpleCourier>> getCouriers(BuildContext context) async {
  String json = await apiRequest(
    context: context,
    route: '/api/users/couriers/couriers_for_administration',
  );

  Map<String, dynamic> parsedJson =
      jsonDecode(json).cast<Map<String, dynamic>>();

  return parsedJson['couriers']
      .cast<List<Map<String, dynamic>>>()
      .filter<List<Map<String, dynamic>>>((json) => !json['is_deleted'])
      .map<SimpleCourier>(
        (json) => SimpleCourier.fromJson(
          json,
          parsedJson['coords'].cast<List<Map<String, dynamic>>>(),
        ),
      )
      .toList();
}

Future<void> newCourier(
  BuildContext context,
  SimpleCourier courier,
) async {
  await apiRequest(
    context: context,
    route: '/api/users/couriers/new',
    body: courier.json,
  );
}

Future<void> blockUnblockCourier(
  BuildContext context,
  SimpleCourier courier,
) async {
  await apiRequest(
    context: context,
    route: '/api/users/couriers/toggle_ban',
    body: courier.jsonID,
  );
}

Future<void> deleteCourier(
  BuildContext context,
  SimpleCourier courier,
) async {
  await apiRequest(
    context: context,
    route: '/api/users/couriers/delete',
    body: courier.jsonID,
  );
}

Future<void> discardCourier(
  BuildContext context,
  SimpleCourier courier,
  DiscardType type,
) async {
  await apiRequest(
    context: context,
    route: '/api/users/couriers/null_money',
    body: courier.jsonDiscard(type),
  );
}
