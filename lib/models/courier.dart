import 'package:topgo/models/order.dart';
import 'package:topgo/models/simple_courier.dart';

class Courier {
  void Function() notify;

  bool blocked, warned, deleted;
  double rating, cash, terminal, salary;
  List<Order> orders, ordersRequest;

  List<Order> history, shownHistory;
  WorkShift? shift;

  Courier.fromJson(
    Map<String, dynamic> json,
    Map<String, dynamic>? session, {
    required this.notify,
  })  : blocked = json['is_bloked'] ?? false,
        warned = json['is_warned'],
        deleted = json['is_deleted'],
        rating = double.parse(
          (json['current_rate_count'] ?? 0 / json['current_rate_amount'] ?? 1)
              .toStringAsFixed(1),
        ),
        cash = json['cash'] / 100,
        terminal = json['term'] / 100,
        salary = json['salary'] / 100,
        orders = [],
        ordersRequest = [],
        history = [],
        shownHistory = [],
        shift = session != null ? WorkShift.fromJson(session) : null;

  void startWorkShift({required WorkShift shift}) {
    this.shift = shift;
    notify();
  }

  void stopWorkShift() {
    this.shift = null;
    notify();
  }

  void updateView(String key) {
    key = key.toLowerCase();
    if (key == '') {
      this.shownHistory = this.history;
    } else {
      List<Order> res = [];
      for (Order item in this.history) {
        if (item.fromAddress!.toLowerCase().contains(key) ||
            item.toAddress!.toLowerCase().contains(key)) res.add(item);
      }
      this.shownHistory = res;
    }
  }
}
