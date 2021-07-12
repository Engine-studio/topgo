import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:location/location.dart';
import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/simple_curator.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/user.dart';

Future<bool> startWorkShift(
  BuildContext context,
  WorkShift shift,
) async {
  try {
    await apiRequest(
      context: context,
      route: '/api/ordering/create_session',
      body: shift.json,
    );
    return Future.value(true);
  } catch (_) {
    return Future.value(false);
  }
}

Future<bool> stopWorkShift(BuildContext context) async {
  try {
    await apiRequest(
      context: context,
      route: '/api/ordering/cancel_session',
    );
    return Future.value(true);
  } catch (_) {
    return Future.value(false);
  }
}

Future<SimpleCurator> callHelper(BuildContext context) async {
  String json = await apiRequest(
    context: context,
    route: '/api/users/curators/get_random',
  );

  return SimpleCurator.fromJson(jsonDecode(json).cast<Map<String, dynamic>>());
}

Future<void> sendLocation(
  BuildContext context,
  LocationData locationData,
) async {
  await apiRequest(
    context: context,
    route: '/api/location/add',
    body: jsonEncode({
      'courier_id': context.read<User>().id,
      'location': {
        'lat': locationData.latitude,
        'lng': locationData.longitude,
      }
    }),
  );
}

Future<void> clearLocation(BuildContext context) async => await apiRequest(
      context: context,
      route: '/api/location/remove',
    );
