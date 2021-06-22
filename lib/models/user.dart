import 'package:flutter/material.dart';

enum Role {
  Administrator,
  Courier,
  Curator,
}

class User with ChangeNotifier {
  Role role;
  bool authorized;

  User()
      : role = Role.Administrator,
        authorized = false;

  User.authorized()
      : role = Role.Courier,
        authorized = true;

  User.nonAuthorized()
      : role = Role.Courier,
        authorized = false;
}
