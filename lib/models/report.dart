class Report {
  int? id;
  String? date, additional, link;

  Report.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        additional = json['additional'],
        link = json['link'];
}
