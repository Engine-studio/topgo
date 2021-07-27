import 'dart:convert' show jsonDecode;

import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/restaurant.dart';
import 'package:topgo/models/user.dart';
import 'package:provider/provider.dart';

Future<List<Restaurant>> getRestaurants(BuildContext context) async {
  String json = await apiRequest(
    context: context,
    route: '/api/users/restaurants/get_all',
  );

  context.read<User>().restaurants = jsonDecode(json)
      .cast<Map<String, dynamic>>()
      .where((json) => !json['is_deleted'])
      .map<Restaurant>((json) => Restaurant.fromJson(json))
      .toList();

  return Future.value([]);
}

Future<bool> newRestaurant(
  BuildContext context,
  Restaurant restaurant,
) async {
  try {
    await apiRequest(
      context: context,
      route: '/api/users/restaurants/new',
      body: restaurant.json,
    );
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> deleteRestaurant(
  BuildContext context,
  Restaurant restaurant,
) async {
  try {
    await apiRequest(
      context: context,
      route: '/api/users/restaurants/delete',
      body: restaurant.jsonID,
    );
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
