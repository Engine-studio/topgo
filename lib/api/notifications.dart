import 'dart:convert';

import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/notification.dart' as topgo;

Future<List<topgo.Notification>> getNotifications(BuildContext context) async {
  String json = await apiRequest(
    context: context,
    route: '/api/ordering/get_notifications',
  );

  return jsonDecode(json)
      .cast<Map<String, dynamic>>()
      .map<topgo.Notification>((json) => topgo.Notification.fromJson(json))
      .toList();
}

Future<void> createNotification(
  BuildContext context,
  topgo.Notification notification,
) async =>
    await apiRequest(
      context: context,
      route: '/api/ordering/send_notification',
      body: notification.json,
    );
