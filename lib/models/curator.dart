import 'package:topgo/models/restaurant.dart';
import 'package:topgo/models/simple_courier.dart';

class Curator {
  void Function() notify;

  List<SimpleCourier> couriers, shownCouriers;
  List<Restaurant> restaurants, shownRestaurants;

  Curator({required this.notify})
      : this.couriers = [],
        this.shownCouriers = [],
        this.restaurants = [],
        this.shownRestaurants = [];

  void updateView(String key) {
    key = key.toLowerCase();
    if (key == '') {
      this.shownCouriers = this.couriers;
      this.shownRestaurants = this.shownRestaurants;
    } else {
      List<SimpleCourier> resCouriers = [];
      for (SimpleCourier item in this.couriers) {
        if (item.action!.toLowerCase().contains(key) ||
            item.fullName.toLowerCase().contains(key) ||
            item.phone.toLowerCase().contains(key)) resCouriers.add(item);
      }
      this.shownCouriers = resCouriers;

      List<Restaurant> resRestaurants = [];
      for (Restaurant item in this.restaurants) {
        if (item.name!.toLowerCase().contains(key) ||
            item.address!.toLowerCase().contains(key) ||
            item.phone!.toLowerCase().contains(key)) resRestaurants.add(item);
      }
      this.shownRestaurants = resRestaurants;
    }
  }
}
