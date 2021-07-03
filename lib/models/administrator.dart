import 'package:topgo/models/restaurant.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/simple_curator.dart';

class Administrator {
  void Function() notify;

  List<SimpleCourier> couriers, shownCouriers;
  List<SimpleCurator> curators, shownCurators;
  List<Restaurant> restaurants, shownRestaurants;

  Administrator({required this.notify})
      : this.couriers = [],
        this.shownCouriers = [],
        this.curators = [],
        this.shownCurators = [],
        this.restaurants = [],
        this.shownRestaurants = [];

  void updateView(String key) {
    key = key.toLowerCase();
    if (key == '') {
      this.shownCouriers = this.couriers;
      this.shownCurators = this.curators;
      this.shownRestaurants = this.restaurants;
    } else {
      List<SimpleCourier> resCouriers = [];
      for (SimpleCourier item in this.couriers) {
        if (item.action!.toLowerCase().contains(key) ||
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
        if (item.name!.toLowerCase().contains(key) ||
            item.address!.toLowerCase().contains(key) ||
            item.phone!.toLowerCase().contains(key)) resRestaurants.add(item);
      }
      this.shownRestaurants = resRestaurants;
    }
  }
}
