import 'package:topgo/models/courier_history.dart';
import 'package:topgo/models/report.dart';
import 'package:topgo/models/work_shift.dart';

class Courier {
  void Function() notify;

  String surname, name, patronymic, phone;
  double rating;
  bool working;
  List<CourierHistoryItem> history, shownHistory;
  List<Report> reports;
  int orders;
  WorkShift shift;

  Courier({
    required this.notify,
    required this.surname,
    required this.name,
    required this.patronymic,
    required this.rating,
    required this.phone,
  })  : working = false,
        orders = 1,
        reports = [
          Report(date: '14.05.21', shift: 'Смена 4'),
          Report(date: '13.05.21', shift: 'Смена 3'),
          Report(date: '12.05.21', shift: 'Смена 2'),
          Report(date: '11.05.21', shift: 'Смена 1'),
        ],
        history = [],
        shownHistory = [],
        shift = WorkShift.none() {
    this.history = [
      CourierHistoryItem(
        from: 'Проспект 60-летия Октября, дом 11, корпус 3, строение 1 ' +
            'подъезд 2, квартира 64 и дальше тоже текст',
        to: 'Проспект 60-летия Октября, дом 11, корпус 3, строение 1 ' +
            'подъезд 2, квартира 64 и дальше тоже текст',
        time: 5,
        payment: 'терминал',
        sum: 10000,
        viewPoint: 4.5,
        behaviorPoint: 4.5,
        timeFrom: [12, 30],
        timeTo: [13, 10],
      ),
      CourierHistoryItem(
        from: 'МОСКВА',
        to: 'Saint-Petersburg',
        time: 5,
        payment: 'терминал',
        sum: 10000,
        viewPoint: 4.5,
        behaviorPoint: 4.5,
        timeFrom: [12, 30],
        timeTo: [13, 10],
      ),
      CourierHistoryItem(
        from: 'Санкт-Петербург',
        to: 'Moscow',
        time: 5,
        payment: 'терминал',
        sum: 10000,
        viewPoint: 4.5,
        behaviorPoint: 4.5,
        timeFrom: [12, 30],
        timeTo: [13, 10],
      ),
      CourierHistoryItem(
        from: 'Vabu labu dab dab MoScOw Saint-Petersburg',
        to: 'Moscow',
        time: 5,
        payment: 'терминал',
        sum: 10000,
        viewPoint: 4.5,
        behaviorPoint: 4.5,
        timeFrom: [12, 30],
        timeTo: [13, 10],
      ),
    ];
    this.shownHistory = this.history;
  }

  void startWork({required WorkShift shift}) {
    this.shift = shift;
    this.working = true;
    notify();
  }

  void stopWork() {
    this.working = false;
    notify();
    this.shift = WorkShift.none();
  }

  void updateView(String key) {
    key = key.toLowerCase();
    if (key == '') {
      this.shownHistory = this.history;
    } else {
      List<CourierHistoryItem> res = [];
      for (CourierHistoryItem item in this.history) {
        if (item.from.toLowerCase().contains(key) ||
            item.to.toLowerCase().contains(key)) res.add(item);
      }
      this.shownHistory = res;
    }
  }
}
