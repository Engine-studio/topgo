class CourierHistoryItem {
  String from;
  String to;
  int time;
  String payment;
  double sum;
  double viewPoint, behaviorPoint;
  List<int> timeFrom;
  List<int> timeTo;

  CourierHistoryItem({
    required this.from,
    required this.to,
    required this.time,
    required this.payment,
    required this.sum,
    required this.viewPoint,
    required this.behaviorPoint,
    required this.timeFrom,
    required this.timeTo,
  });

  List<CourierHistoryItem> get example {
    return [
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
    ];
  }
}
