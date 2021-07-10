import 'dart:convert' show jsonDecode;

import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/simple_curator.dart';

Future<List<SimpleCurator>> getCurators(BuildContext context) async {
  String json =
      await apiRequest(context: context, route: '/api/users/curators/get_all');

  return jsonDecode(json)
      .cast<List<Map<String, dynamic>>>()
      .filter<List<Map<String, dynamic>>>((json) => !json['is_deleted'])
      .map<SimpleCurator>((json) => SimpleCurator.fromJson(json))
      .toList();
}

Future<void> newCurator(BuildContext context, SimpleCurator curator) async {
  await apiRequest(
    context: context,
    route: '/api/users/curators/new',
    body: curator.json,
  );
}

Future<void> deleteCurator(BuildContext context, SimpleCurator curator) async {
  await apiRequest(
    context: context,
    route: '/api/users/curators/delete',
    body: curator.jsonID,
  );
}
