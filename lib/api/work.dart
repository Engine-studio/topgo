import 'dart:convert' show jsonDecode;

import 'package:location/location.dart';
import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/simple_curator.dart';

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
  // await apiRequest(
  //   context: context,
  //   route: 'route',
  // );
}
