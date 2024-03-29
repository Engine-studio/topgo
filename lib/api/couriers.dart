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

  List<int> ids = List.empty(growable: true);

  List<SimpleCourier> cours = parsedJson['couriers']
      .cast<Map<String, dynamic>>()
      .where((json) => !json['is_deleted'])
      .map<SimpleCourier>((json) => SimpleCourier.fromJson(
            json,
            parsedJson['coords'].cast<Map<String, dynamic>>(),
          ))
      .toList();

  List<SimpleCourier> approvedCours = List.empty(growable: true);

  for (SimpleCourier c in cours) {
    if (!ids.contains(c.id)) {
      approvedCours.add(c);
      ids.add(c.id!);
    }
  }

  context.read<User>().couriers = approvedCours;

  return Future.value([]);
}

Future<bool> newCourier(
  BuildContext context,
  SimpleCourier courier,
) async {
  try {
    await apiRequest(
      context: context,
      route: '/api/users/couriers/new',
      body: courier.json,
    );
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> blockUnblockCourier(
  BuildContext context,
  SimpleCourier courier,
) async {
  try {
    await apiRequest(
      context: context,
      route: '/api/users/couriers/toggle_ban',
      body: courier.jsonID,
    );
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> deleteCourier(
  BuildContext context,
  SimpleCourier courier,
) async {
  try {
    await apiRequest(
      context: context,
      route: '/api/users/couriers/delete',
      body: courier.jsonID,
    );
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> discardCourier(
  BuildContext context,
  SimpleCourier courier,
  DiscardType type,
) async {
  try {
    await apiRequest(
      context: context,
      route: '/api/users/couriers/null_money',
      body: courier.jsonDiscard(type),
    );
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
