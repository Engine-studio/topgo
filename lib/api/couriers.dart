import 'dart:convert' show jsonDecode;

import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/user.dart';

Future<List<SimpleCourier>> getCouriers(BuildContext context) async {
  String json = await apiRequest(
    context: context,
    route: '/api/users/couriers/couriers_for_administration',
  );
  Map<String, dynamic> parsedJson = jsonDecode(json);

  context.read<User>().couriers = parsedJson['couriers']
      .cast<Map<String, dynamic>>()
      .where((json) => !json['is_deleted'])
      .map<SimpleCourier>(
        (json) => SimpleCourier.fromJson(
          json,
          parsedJson['coords'].cast<Map<String, dynamic>>(),
        ),
      )
      .toList();

  return Future.value([]);
}

Future<void> newCourier(
  BuildContext context,
  SimpleCourier courier,
) async =>
    await apiRequest(
      context: context,
      route: '/api/users/couriers/new',
      body: courier.json,
    );

Future<void> blockUnblockCourier(
  BuildContext context,
  SimpleCourier courier,
) async =>
    await apiRequest(
      context: context,
      route: '/api/users/couriers/toggle_ban',
      body: courier.jsonID,
    );

Future<void> deleteCourier(
  BuildContext context,
  SimpleCourier courier,
) async =>
    await apiRequest(
      context: context,
      route: '/api/users/couriers/delete',
      body: courier.jsonID,
    );

Future<void> discardCourier(
  BuildContext context,
  SimpleCourier courier,
  DiscardType type,
) async =>
    await apiRequest(
      context: context,
      route: '/api/users/couriers/null_money',
      body: courier.jsonDiscard(type),
    );
