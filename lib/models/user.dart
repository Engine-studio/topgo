import 'package:flutter/material.dart';

enum Role {
  Administrator,
  Courier,
  Curator,
}

class User with ChangeNotifier {
  Role role;
  bool authorized;
  bool working;
  int orders;

  User()
      : role = Role.Administrator,
        authorized = false,
        working = false,
        orders = 1;

  User.authorized()
      : role = Role.Courier,
        authorized = true,
        working = true,
        orders = 1;

  User.nonAuthorized()
      : role = Role.Courier,
        authorized = false,
        working = false,
        orders = 1;

  void work() {
    this.working = !this.working;
    notifyListeners();
  }

  void add() {
    this.orders += 1;
    notifyListeners();
  }
}
