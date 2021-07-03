import 'package:topgo/models/report.dart';
import 'package:topgo/models/restaurant.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/simple_curator.dart';

class Administrator {
  void Function() notify;

  String surname, name, patronymic, phone;

  List<SimpleCourier> couriers, shownCouriers;
  List<Report> reports;
  List<SimpleCurator> curators, shownCurators;
  List<Restaurant> restaurants, shownRestaurants;

  Administrator({
    required this.notify,
    required this.surname,
    required this.name,
    required this.patronymic,
    required this.phone,
  })  : this.couriers = [],
        this.shownCouriers = [],
        this.curators = [],
        this.shownCurators = [],
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
        'Addressline  as as das da sd asd as das da das MOSCOW das das d asd asd as das das d as ads as das d as da sad s',
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
    this.reports = [
      Report(date: '14.05.21'),
      Report(date: '13.05.21'),
      Report(date: '12.05.21'),
      Report(date: '11.05.21'),
    ];
    this.curators = [
      SimpleCurator(
        'asdasdasfdsf sdafdsafsdaf asdfasdfdasfsadasfd',
        '+7 (977) 783-23-21',
        'https://st.depositphotos.com/1034986/5054/i/600/depositphotos_50542655-stock-photo-man-working-home-using-laptop.jpg',
        true,
      ),
      SimpleCurator(
        'Ivan Ajdjfjjfjffjjf Olololo',
        '+7 (900) 132-23-21',
        'https://st.depositphotos.com/1034986/5054/i/600/depositphotos_50542683-stock-photo-man-working-home-using-laptop.jpg',
        false,
      ),
      SimpleCurator(
        'Alexeu BJBJgfgf Alexandrovich',
        '+7 (915) 488-23-00',
        'https://images11.bazaar.ru/upload/custom/41e/41e2d41f595c12525ae8edc80c68bc1c.jpg',
        false,
      ),
    ];
    this.shownCurators = this.curators;
  }

  void updateView(String key) {
    key = key.toLowerCase();
    if (key == '') {
      this.shownCouriers = this.couriers;
      this.shownCurators = this.curators;
      this.shownRestaurants = this.restaurants;
    } else {
      List<SimpleCourier> resCouriers = [];
      for (SimpleCourier item in this.couriers) {
        if (item.action.toLowerCase().contains(key) ||
            item.fullName.toLowerCase().contains(key) ||
            item.phone.toLowerCase().contains(key)) resCouriers.add(item);
      }
      this.shownCouriers = resCouriers;

      List<SimpleCurator> resCurators = [];
      for (SimpleCurator item in this.curators) {
        if (item.fullName.toLowerCase().contains(key) ||
            item.phone.toLowerCase().contains(key)) resCurators.add(item);
      }
      this.shownCurators = resCurators;

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
