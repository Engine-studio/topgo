class Curator {
  void Function() notify;

  String surname, name, patronymic, phone;

  Curator({
    required this.notify,
    required this.surname,
    required this.name,
    required this.patronymic,
    required this.phone,
  });

  // void updateView(String key) {
  //   key = key.toLowerCase();
  //   if (key == '') {
  //     this.shownHistory = this.history;
  //   } else {
  //     List<CourierHistoryItem> res = [];
  //     for (CourierHistoryItem item in this.history) {
  //       if (item.from.toLowerCase().contains(key) ||
  //           item.to.toLowerCase().contains(key)) res.add(item);
  //     }
  //     this.shownHistory = res;
  //   }
  // }
}
