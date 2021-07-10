import 'package:topgo/api/general.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/notification.dart' as topgo;

// TODO: Change route
Future<void> createNotification(
  BuildContext context,
  topgo.Notification notification,
) async {
  await apiRequest(
    context: context,
    route: '/api/shit',
    body: notification.json,
  );
}
