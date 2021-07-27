import 'dart:convert' show jsonDecode;

import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/simple_curator.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/user.dart';

Future<List<SimpleCurator>> getCurators(BuildContext context) async {
  String json =
      await apiRequest(context: context, route: '/api/users/curators/get_all');

  context.read<User>().curators = jsonDecode(json)
      .cast<Map<String, dynamic>>()
      .where((json) => !json['is_deleted'])
      .map<SimpleCurator>((json) => SimpleCurator.fromJson(json))
      .toList();

  return Future.value([]);
}

Future<bool> newCurator(
  BuildContext context,
  SimpleCurator curator,
) async {
  try {
    await apiRequest(
      context: context,
      route: '/api/users/curators/new',
      body: curator.json,
    );
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> deleteCurator(
  BuildContext context,
  SimpleCurator curator,
) async {
  try {
    await apiRequest(
      context: context,
      route: '/api/users/curators/delete',
      body: curator.jsonID,
    );
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
