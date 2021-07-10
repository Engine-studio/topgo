import 'dart:convert' show jsonDecode;

import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/restaurant.dart';

Future<List<Restaurant>> getRestaurants(BuildContext context) async {
  String json = await apiRequest(
    context: context,
    route: '/api/users/restaurants/get_all',
  );

  return jsonDecode(json)
      .cast<List<Map<String, dynamic>>>()
      .filter<List<Map<String, dynamic>>>((json) => !json['is_deleted'])
      .map<Restaurant>(
        (json) => Restaurant.fromJson(json),
      )
      .toList();
}

Future<void> newRestaurant(
  BuildContext context,
  Restaurant restaurant,
) async {
  await apiRequest(
    context: context,
    route: '/api/users/restaurants/new',
    body: restaurant.json,
  );
}

Future<void> deleteRestaurant(
  BuildContext context,
  Restaurant restaurant,
) async {
  await apiRequest(
    context: context,
    route: '/api/users/restaurants/delete',
    body: restaurant.jsonID,
  );
}
