import 'package:flutter/material.dart';
import 'package:topgo/models/administrator.dart';
import 'package:topgo/models/courier.dart';
import 'package:topgo/models/curator.dart';

enum Role {
  Administrator,
  Courier,
  Curator,
}

class User with ChangeNotifier {
  String token;
  Role role;
  bool authorized;

  late Courier courier;
  late Administrator administrator;
  late Curator curator;

  User()
      : token = 'jwt',
        role = Role.Courier,
        authorized = true {
    this.courier = Courier(notify: notify);
  }

  void notify() => notifyListeners();
}
