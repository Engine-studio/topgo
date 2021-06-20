import 'package:flutter/widgets.dart';
import 'package:topgo/pages/courier/documents.dart';
import 'package:topgo/pages/courier/history.dart';
import 'package:topgo/pages/courier/orders.dart';
import 'package:topgo/pages/courier/profile.dart';

class Items {
  static List<String> bottomNavBarIcons(String role) {
    return [
      'history',
      'rocket',
      'user',
      'documents',
    ];
  }

  static List<Widget> bottomNavBarTabs(String role) {
    return <Widget>[
      CourierHistoryTab(),
      CourierOrdersTab(),
      CourierProfileTab(),
      CourierDocumentsTab(),
    ];
  }
}
