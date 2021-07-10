import 'package:flutter/material.dart';
import 'package:topgo/functions/phone_string.dart';
import 'package:topgo/models/administrator.dart';
import 'package:topgo/models/courier.dart';
import 'package:topgo/models/curator.dart';
import 'package:topgo/models/restaurant.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  User() : logined = false;

  User.fromJson(Map<String, dynamic> json)
      : logined = true,
        role = Role.Administrator;

  User.shadow()
      : logined = true,
        token = 'zxc',
        surname = 'Surname',
        name = 'Name',
        patronymic = 'Patronymic',
        _phone = '79990001234',
        password = '111',
        role = Role.Administrator {
    this.administrator = Administrator(notify: notify);
  }

  void copy(User other) {
    this.logined = other.logined;
    this.token = other.token;
    this.surname = other.surname;
    this.name = other.name;
    this.patronymic = other.patronymic;
    this._phone = other._phone;
    this.image = other.password;
    this.role = other.role;
    this.courier = other.courier;
    this.administrator = other.administrator;
    this.curator = other.curator;
  }

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

  List<String> get loginData => [_phone ?? '', password ?? ''];

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
