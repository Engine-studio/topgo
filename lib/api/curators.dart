import 'dart:convert' show jsonDecode;

import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/simple_curator.dart';

// TODO: Change route
Future<List<SimpleCurator>> getCurators(BuildContext context) async {
  String json = await apiRequest(context: context, route: '/api/shit');

  return jsonDecode(json)
      .cast<List<Map<String, dynamic>>>()
      .map<SimpleCurator>((json) => SimpleCurator.fromJson(json))
      .toList();
}

// TODO: Change route
Future<void> newCurator(BuildContext context, SimpleCurator curator) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: curator.json,
  );
}

// TODO: Change route
Future<bool> blockCurator(BuildContext context, SimpleCurator curator) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: curator.jsonID,
  );

  return Future.value(true);
}

// TODO: Change route
Future<bool> unblockCurator(BuildContext context, SimpleCurator curator) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: curator.jsonID,
  );

  return Future.value(true);
}

// TODO: Change route
Future<bool> deleteCurator(BuildContext context, SimpleCurator curator) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: curator.jsonID,
  );

  return Future.value(true);
}
