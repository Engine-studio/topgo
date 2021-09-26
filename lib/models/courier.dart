import 'dart:convert' show jsonEncode;

import 'package:topgo/models/order.dart';
import 'package:topgo/models/simple_courier.dart';

class Courier {
  void Function() notify;

  bool blocked, warned, deleted;
  double rating, cash, terminal, salary;
  List<Order> orders, ordersRequest;

  List<Order> history, shownHistory;
  WorkShift? shift;

  String get jsonSessionId => jsonEncode({
        "id": shift != null ? shift!.id : -1,
      });

  Courier.fromJson(
    Map<String, dynamic> json,
    Map<String, dynamic>? session, {
    required this.notify,
  })  : blocked = json['is_blocked'] ?? false,
        warned = json['is_warned'],
        deleted = json['is_deleted'],
        rating = double.parse(((json['current_rate_ammount'] ?? 0) /
                (json['current_rate_count'] ?? 1))
            .toStringAsFixed(2)),
        cash = json['cash'] / 100,
        terminal = json['term'] / 100,
        salary = json['salary'] / 100,
        orders = [],
        ordersRequest = [],
        history = [],
        shownHistory = [],
        shift = session != null ? WorkShift.fromJson(session) : null;

  void updateView(String key) {
    key = key.toLowerCase();
    if (key == '') {
      this.shownHistory = this.history;
    } else {
      List<Order> res = [];
      for (Order item in this.history) {
        if ((item.fromAddress != null &&
                item.fromAddress!.toLowerCase().contains(key)) ||
            (item.toAddress != null &&
                item.toAddress!.toLowerCase().contains(key))) res.add(item);
      }
      this.shownHistory = res;
    }
  }
}
