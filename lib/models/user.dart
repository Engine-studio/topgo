import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topgo/functions/phone_string.dart';
import 'package:topgo/models/administrator.dart';
import 'package:topgo/models/courier.dart';
import 'package:topgo/models/curator.dart';
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
      MaterialPageRoute(
          builder: (BuildContext context) => LoginPage(init: false)),
    );
  }

  User.fromJson(
    Map<String, dynamic> json, {
    this.phoneSource,
    this.password,
  })  : logined = true,
        token = json['jwt'] {
    if (json.containsKey('admin')) {
      role = Role.Administrator;
      json = json['admin'];
      administrator = Administrator.fromJson(json, notify: notify);
    } else if (json.containsKey('curator')) {
      role = Role.Curator;
      json = json['curator'];
      curator = Curator(json, notify: notify);
    } else if (json.containsKey('courier')) {
      role = Role.Courier;
      Map<String, dynamic>? session = json['session'];
      json = json['courier'];
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

  void addCourier(SimpleCourier courier) {
    if (role == Role.Administrator) {
      administrator!.couriers.add(courier);
      administrator!.shownCouriers.add(courier);
      administrator!.notify();
    } else {
      curator!.couriers.add(courier);
      curator!.shownCouriers.add(courier);
      curator!.notify();
    }
  }

  void addCurator(SimpleCurator curator) {
    administrator!.curators.add(curator);
    administrator!.shownCurators.add(curator);
    administrator!.notify();
  }

  void deleteCourier(SimpleCourier courier) {
    if (role == Role.Administrator) {
      administrator!.couriers.remove(courier);
      administrator!.shownCouriers.remove(courier);
      administrator!.notify();
    } else {
      curator!.couriers.remove(courier);
      curator!.shownCouriers.remove(courier);
      curator!.notify();
    }
  }

  void deleteCurator(SimpleCurator curator) {
    administrator!.curators.remove(curator);
    administrator!.shownCurators.remove(curator);
    administrator!.notify();
  }

  void blockUnblockCourier(SimpleCourier courier) {
    SimpleCourier _courier = courier;
    _courier.blocked = !courier.blocked!;
    _courier.action = _courier.blocked! ? 'Заблокирован' : 'Обновите данные';
    if (role == Role.Administrator) {
      int index = administrator!.couriers.indexOf(courier);
      administrator!.couriers[index] = _courier;
      index = administrator!.shownCouriers.indexOf(courier);
      if (index != -1) administrator!.shownCouriers[index] = _courier;
      administrator!.notify();
    } else {
      int index = curator!.couriers.indexOf(courier);
      curator!.couriers[index] = _courier;
      index = curator!.shownCouriers.indexOf(courier);
      if (index != -1) curator!.shownCouriers[index] = _courier;
      curator!.notify();
    }
  }

  void discardCourier(SimpleCourier courier, DiscardType type) {
    print('from ${courier.fullName} and term ${courier.terminal}');
    SimpleCourier _courier = courier;
    _courier.discard(type);
    print('toto ${_courier.fullName} and term ${_courier.terminal}');
    print('from ${courier.fullName} and term ${courier.cash}');
    if (role == Role.Administrator) {
      int index = administrator!.couriers.indexOf(courier);
      administrator!.couriers[index] = _courier;
      index = administrator!.shownCouriers.indexOf(courier);
      if (index != -1) administrator!.shownCouriers[index] = _courier;
      administrator!.notify();
    } else {
      int index = curator!.couriers.indexOf(courier);
      curator!.couriers[index] = _courier;
      index = curator!.shownCouriers.indexOf(courier);
      if (index != -1) curator!.shownCouriers[index] = _courier;
      curator!.notify();
    }
  }

  void addRestaurant(Restaurant restaurant) {
    if (role == Role.Administrator) {
      administrator!.restaurants.add(restaurant);
      administrator!.shownRestaurants.add(restaurant);
      administrator!.notify();
    } else {
      curator!.restaurants.add(restaurant);
      curator!.shownRestaurants.add(restaurant);
      curator!.notify();
    }
  }

  void deleteRestaurant(Restaurant restaurant) {
    if (role == Role.Administrator) {
      administrator!.restaurants.remove(restaurant);
      administrator!.shownRestaurants.remove(restaurant);
      administrator!.notify();
    } else {
      curator!.restaurants.remove(restaurant);
      curator!.shownRestaurants.remove(restaurant);
      curator!.notify();
    }
  }
}
