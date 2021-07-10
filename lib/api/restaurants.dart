import 'dart:convert' show jsonDecode;

import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/restaurant.dart';

// TODO: Change route
Future<List<Restaurant>> getRestaurants(BuildContext context) async {
  String json = await apiRequest(context: context, route: '/api/shit');

  return jsonDecode(json)
      .cast<List<Map<String, dynamic>>>()
      .map<Restaurant>((json) => Restaurant.fromJson(json))
      .toList();
}

// TODO: Change route
Future<void> newRestaurant(BuildContext context, Restaurant restaurant) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: restaurant.json,
  );
}

// TODO: Change route
Future<bool> deleteRestaurant(
    BuildContext context, Restaurant restaurant) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: restaurant.json,
  );

  return Future.value(true);
}
