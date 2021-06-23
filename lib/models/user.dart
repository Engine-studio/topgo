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

  User()
      : role = Role.Administrator,
        authorized = false,
        working = false;

  User.authorized()
      : role = Role.Courier,
        authorized = true,
        working = true;

  User.nonAuthorized()
      : role = Role.Courier,
        authorized = false,
        working = false;

  void work() {
    this.working = !this.working;
    notifyListeners();
  }
}
