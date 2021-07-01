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
}
