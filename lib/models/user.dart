import 'package:flutter/material.dart';
import 'package:topgo/functions/phone_string.dart';
import 'package:topgo/models/administrator.dart';
import 'package:topgo/models/courier.dart';
import 'package:topgo/models/curator.dart';
import 'package:topgo/models/restaurant.dart';
import 'package:topgo/models/simple_courier.dart';

enum Role {
  Administrator,
  Courier,
  Curator,
}

class User with ChangeNotifier {
  bool logined;
  String? token, surname, name, patronymic, _phone, image, password;
  Role? role;

  Courier? courier;
  Administrator? administrator;
  Curator? curator;

  //TODO: remove role
  User()
      : logined = false,
        role = Role.Administrator;

  void updateView(String key) {
    role == Role.Administrator
        ? administrator!.updateView(key)
        : role == Role.Courier
            ? courier!.updateView(key)
            : curator!.updateView(key);
    notifyListeners();
  }

  void notify() => notifyListeners();

  String get fullName => '${surname!} ${name!} ${patronymic!}';
  String get phone => phoneString(_phone!);

  set couriers(List<SimpleCourier> couriers) => role == Role.Administrator
      ? {
          administrator!.couriers = couriers,
          administrator!.shownCouriers = couriers,
          notify(),
        }
      : {
          curator!.couriers = couriers,
          curator!.shownCouriers = couriers,
          notify(),
        };

  List<SimpleCourier> get shownCouriers => role == Role.Administrator
      ? administrator!.shownCouriers
      : curator!.shownCouriers;

  set restaurants(List<Restaurant> restaurants) => role == Role.Administrator
      ? {
          administrator!.restaurants = restaurants,
          administrator!.shownRestaurants = restaurants,
          notify(),
        }
      : {
          curator!.restaurants = restaurants,
          curator!.shownRestaurants = restaurants,
          notify(),
        };

  List<Restaurant> get shownRestaurants => role == Role.Administrator
      ? administrator!.shownRestaurants
      : curator!.shownRestaurants;
}
