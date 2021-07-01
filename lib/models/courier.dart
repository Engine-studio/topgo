import 'package:topgo/models/courier_history.dart';
import 'package:topgo/models/work_shift.dart';

class Courier {
  void Function() notify;
  bool working;
  List<CourierHistoryItem> history;
  int orders;
  WorkShift shift;

  Courier({required this.notify})
      : working = false,
        orders = 1,
        history = [
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
        ],
        shift = WorkShift.none();

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
}
