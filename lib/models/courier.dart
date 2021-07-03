import 'package:topgo/models/order.dart';
import 'package:topgo/models/simple_courier.dart';

class Courier {
  void Function() notify;

  double rating, cash, terminal, salary;
  List<Order> orders;

  List<Order> history, shownHistory;
  WorkShift? shift;

  Courier({required this.notify})
      : rating = 0,
        cash = 0,
        terminal = 0,
        salary = 0,
        orders = [],
        history = [],
        shownHistory = [];

// TODO: change .MD and response
  Courier.fromJson(Map<String, dynamic> json, {required this.notify})
      : rating = json['rating'],
        cash = json['cash'],
        terminal = json['terminal'],
        salary = json['salary'],
        orders = [],
        history = [],
        shownHistory = [],
        shift = json['shift'] != null
            ? WorkShift.fromJson(json['shift'].cast<Map<String, dynamic>>())
            : null;

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
        if (item.from!.toLowerCase().contains(key) ||
            item.to!.toLowerCase().contains(key)) res.add(item);
      }
      this.shownHistory = res;
    }
  }
}
