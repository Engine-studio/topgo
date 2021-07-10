import 'dart:convert' show jsonDecode;

import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/simple_curator.dart';

Future<void> startWorkShift(
  BuildContext context,
  WorkShift shift,
) async {
  await apiRequest(
    context: context,
    route: '/api/ordering/create_session',
    body: shift.json,
  );
}

Future<void> stopWorkShift(BuildContext context) async {
  await apiRequest(
    context: context,
    route: '/api/ordering/cancel_session',
  );
}

Future<SimpleCurator> callHelper(BuildContext context) async {
  String json = await apiRequest(
    context: context,
    route: '/api/users/curators/get_random',
  );

  return SimpleCurator.fromJson(jsonDecode(json).cast<Map<String, dynamic>>());
}
