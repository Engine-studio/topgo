class Report {
  int id;
  String date;
  String shift;
  String link;

  Report({
    this.id = -1,
    this.shift = '',
    required this.date,
    this.link = '',
  });
}
