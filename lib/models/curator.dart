import 'package:topgo/models/report.dart';
import 'package:topgo/models/restaurant.dart';
import 'package:topgo/models/simple_courier.dart';

class Curator {
  void Function() notify;

  String surname, name, patronymic, phone;

  List<SimpleCourier> couriers, shownCouriers;
  List<Report> reports;
  List<Restaurant> restaurants, shownRestaurants;

  Curator({
    required this.notify,
    required this.surname,
    required this.name,
    required this.patronymic,
    required this.phone,
  })  : this.couriers = [],
        this.shownCouriers = [],
        this.reports = [],
        this.restaurants = [],
        this.shownRestaurants = [] {
    this.restaurants = [
      Restaurant(
        'Restoran1',
        'Addressline  as as das da sd Saint-Petersburg das da das d as das das d ',
        [10, 0],
        [22, 30],
        '+7 (977) 270-23-21',
      ),
      Restaurant(
        'CrustyCrabs',
        'Addressline  as as das da sd asd as das da das MOSCOW ',
        [12, 45],
        [20, 0],
        '+7 (900) 44-00-12',
      ),
    ];
    this.shownRestaurants = this.restaurants;
    this.couriers = [
      SimpleCourier(
        'Alex asdasdasdsadf sadfasfasdf',
        'Доставляет заказ :1231313',
        '+7 (977) 270-23-21',
        3,
        0,
        5342,
        1234,
        123,
        'https://wl-adme.cf.tsp.li/resize/728x/jpg/7eb/128/740dd3588cb68498765196a0a9.jpg',
      ),
      SimpleCourier(
        'Bill ddsakjfajksdhf Torwaldosn',
        'Забирает заказ :1231313',
        '+7 (977) 154-23-21',
        4.5,
        1,
        1234,
        10000,
        100000,
        'https://www.psychologos.ru/images/1_1435913180.png',
      ),
      SimpleCourier(
        'Tretyakov Nikolay Nachalnikovich123123',
        'Заблокирован',
        '+7 (977) 783-23-21',
        4.9,
        2,
        1000,
        50320,
        12312,
        'https://kubnews.ru/upload/iblock/ac3/ac340e522f20949db0536de80924a080.jpg',
      ),
    ];
    this.shownCouriers = this.couriers;
    reports = [
      Report(date: '14.05.21'),
      Report(date: '13.05.21'),
      Report(date: '12.05.21'),
      Report(date: '11.05.21'),
    ];
  }

  void updateView(String key) {
    key = key.toLowerCase();
    if (key == '') {
      this.shownCouriers = this.couriers;
      this.shownRestaurants = this.shownRestaurants;
    } else {
      List<SimpleCourier> resCouriers = [];
      for (SimpleCourier item in this.couriers) {
        if (item.action.toLowerCase().contains(key) ||
            item.fullName.toLowerCase().contains(key) ||
            item.phone.toLowerCase().contains(key)) resCouriers.add(item);
      }
      this.shownCouriers = resCouriers;

      List<Restaurant> resRestaurants = [];
      for (Restaurant item in this.restaurants) {
        if (item.name.toLowerCase().contains(key) ||
            item.address.toLowerCase().contains(key) ||
            item.phone.toLowerCase().contains(key)) resRestaurants.add(item);
      }
      this.shownRestaurants = resRestaurants;
    }
  }
}
