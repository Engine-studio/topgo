import 'dart:convert' show jsonDecode;

import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/simple_curator.dart';

// TODO: Change route
Future<void> startWorkShift(BuildContext context, WorkShift shift) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: shift.json,
  );
}

// TODO: Change route
Future<void> stopWorkShift(BuildContext context) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
  );
}

// TODO: Change route
Future<SimpleCurator> callHelper(BuildContext context) async {
  String json = await apiRequest(context: context, route: '/api/shit');

  return SimpleCurator.helperFromJson(
      jsonDecode(json).cast<Map<String, dynamic>>());
}
