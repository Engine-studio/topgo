import 'package:flutter/material.dart';
import 'package:topgo/functions/phone_string.dart';
import 'package:topgo/models/administrator.dart';
import 'package:topgo/models/courier.dart';
import 'package:topgo/models/curator.dart';
import 'package:topgo/models/restaurant.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/api/general.dart';

enum Role {
  Administrator,
  Courier,
  Curator,
}

class User with ChangeNotifier {
  bool logined;
  int? id;
  String? token, surname, name, patronymic, phoneSource, image, password;
  Role? role;

  Courier? courier;
  Administrator? administrator;
  Curator? curator;

  User() : logined = false;

  User.fromJson(
    Map<String, dynamic> json, {
    this.phoneSource,
    this.password,
  })  : logined = true,
        token = json['jwt'] {
    if (json.containsKey('admin')) {
      role = Role.Administrator;
      json = json['admin'].cast < Map<String, dynamic>();
      administrator = Administrator.fromJson(json, notify: notify);
    } else if (json.containsKey('curator')) {
      role = Role.Curator;
      json = json['curator'].cast < Map<String, dynamic>();
      curator = Curator(json, notify: notify);
    } else if (json.containsKey('courier')) {
      role = Role.Courier;
      Map<String, dynamic>? session =
          json['session'].cast<Map<String, dynamic>>();
      json = json['courier'].cast < Map<String, dynamic>();
      courier = Courier.fromJson(json, session, notify: notify);
    }
    id = json['id'];
    surname = json['surname'];
    name = json['name'];
    patronymic = json['patronymic'];
    phoneSource = json['phone'];
    image = json['picture'];
  }

  void copy(User other) {
    this.logined = other.logined;
    this.token = other.token;
    this.surname = other.surname;
    this.name = other.name;
    this.patronymic = other.patronymic;
    this.phoneSource = other.phoneSource;
    this.password = other.password;
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

  void updatePhoto(String? image) {
    this.image = image ?? this.image;
    notifyListeners();
  }

  void notify() => notifyListeners();

  String get fullName => '${surname!} ${name!} ${patronymic!}';
  String get phone => phoneString(phoneSource!);
  String get photo => image != null ? 'https://$host/${image!}' : default_photo;

  Map<String, String> get loginData => {
        'phone': phoneSource ?? '',
        'password': password ?? '',
      };

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
