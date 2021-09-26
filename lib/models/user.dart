import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topgo/functions/phone_string.dart';
import 'package:topgo/models/administrator.dart';
import 'package:topgo/models/courier.dart';
import 'package:topgo/models/curator.dart';
import 'package:topgo/models/order.dart';
import 'package:topgo/models/restaurant.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/api/general.dart';
import 'package:topgo/models/simple_curator.dart';
import 'package:topgo/pages/login.dart';

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

  Future<void> logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    this.copy(User());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(init: false)),
    );
  }

  User.fromJson(
    Map<String, dynamic> json, {
    this.phoneSource,
    this.password,
  })  : logined = true,
        token = json['jwt'] {
    Map<String, dynamic> jsonb = Map();
    if (json.containsKey('admin')) {
      role = Role.Administrator;
      jsonb = json['admin'];
      administrator = Administrator.fromJson(jsonb, notify: notify);
    } else if (json.containsKey('curator')) {
      role = Role.Curator;
      jsonb = json['curator'];
      curator = Curator(jsonb, notify: notify);
    } else if (json.containsKey('courier')) {
      role = Role.Courier;
      Map<String, dynamic>? session = json['session'];
      jsonb = json['courier'];
      courier = Courier.fromJson(jsonb, session, notify: notify);
    }
    id = jsonb['id'];
    surname = jsonb['surname'];
    name = jsonb['name'];
    patronymic = jsonb['patronymic'];
    phoneSource = jsonb['phone'];
    image = jsonb['picture'];
  }

  void copy(User other) {
    this.id = other.id;
    this.logined = other.logined;
    this.token = other.token;
    this.surname = other.surname;
    this.name = other.name;
    this.patronymic = other.patronymic;
    this.phoneSource = other.phoneSource;
    this.password = other.password;
    this.image = other.image;
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
  String get photo =>
      this.image != null ? 'https://$host/${image!}' : default_photo;

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

  set curators(List<SimpleCurator> curators) => {
        administrator!.curators = curators,
        administrator!.shownCurators = curators,
        notify(),
      };

  List<SimpleCurator> get shownCurators => administrator!.shownCurators;

  List<Order> get shownHistory => courier!.shownHistory;

  void deleteCourier(SimpleCourier courier) {
    if (role == Role.Administrator) {
      administrator!.couriers.remove(courier);
      administrator!.shownCouriers.remove(courier);
    } else {
      curator!.couriers.remove(courier);
      curator!.shownCouriers.remove(courier);
    }
    notify();
  }

  void deleteRestaurant(Restaurant restaurant) {
    if (role == Role.Administrator) {
      administrator!.restaurants.remove(restaurant);
      administrator!.shownRestaurants.remove(restaurant);
    } else {
      curator!.restaurants.remove(restaurant);
      curator!.shownRestaurants.remove(restaurant);
    }
    notify();
  }

  void deleteCurator(SimpleCurator curator) async {
    administrator!.curators.remove(curator);
    administrator!.shownCurators.remove(curator);
    notify();
  }

  void blockUnblockCourier(SimpleCourier courier) {
    SimpleCourier _courier = courier;
    _courier.blocked = !courier.blocked!;
    _courier.works = false;
    _courier.action = _courier.blocked! ? 'Заблокирован' : 'Неактивен';
    if (role == Role.Administrator) {
      int index = administrator!.couriers.indexOf(courier);
      administrator!.couriers[index] = _courier;
      index = administrator!.shownCouriers.indexOf(courier);
      if (index != -1) administrator!.shownCouriers[index] = _courier;
    } else {
      int index = curator!.couriers.indexOf(courier);
      curator!.couriers[index] = _courier;
      index = curator!.shownCouriers.indexOf(courier);
      if (index != -1) curator!.shownCouriers[index] = _courier;
    }
    notify();
  }

  void discardCourier(SimpleCourier courier, DiscardType type) {
    if (role == Role.Administrator) {
      int index = administrator!.couriers.indexOf(courier);
      administrator!.couriers[index].discard(type);
      index = administrator!.shownCouriers.indexOf(courier);
      if (index != -1) administrator!.shownCouriers[index].discard(type);
    } else {
      int index = curator!.couriers.indexOf(courier);
      curator!.couriers[index].discard(type);
      index = curator!.shownCouriers.indexOf(courier);
      if (index != -1) curator!.shownCouriers[index].discard(type);
    }
    notify();
  }

  void startWorkShift({required WorkShift shift}) {
    notify();
  }

  void stopWorkShift() {
    notify();
  }

  set orders(List<Order> orders) => {
        this.courier!.orders = orders,
        notify(),
      };

  set ordersRequests(List<Order> orders) => {
        this.courier!.ordersRequest = orders,
        notify(),
      };

  set ordersHistory(List<Order> orders) => {
        this.courier!.history = orders,
        this.courier!.shownHistory = orders,
        notify(),
      };

  void removeRequest(Order order) {
    this.courier!.ordersRequest.remove(order);
    notify();
  }

  void removeRequests() {
    this.courier!.ordersRequest = [];
    notify();
  }
}
