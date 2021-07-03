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
        role = Role.Curator,
        authorized = true {
    this.curator = Curator(
      notify: notify,
      surname: 'Третьяков',
      name: 'Николяяяяяя',
      patronymic: 'Дмитриевич',
      phone: '+7 (977) 270-23-21',
    );
  }

  void updateView(String key) {
    switch (this.role) {
      case Role.Administrator:
        //administrator.updateView(key);
        break;
      case Role.Courier:
        courier.updateView(key);
        break;
      case Role.Curator:
        curator.updateView(key);
        break;
    }
    notifyListeners();
  }

  String get fullName {
    switch (this.role) {
      case Role.Administrator:
        return this.administrator.surname +
            ' ' +
            this.administrator.name +
            ' ' +
            this.administrator.patronymic;
      case Role.Courier:
        return this.courier.surname +
            ' ' +
            this.courier.name +
            ' ' +
            this.courier.patronymic;
      case Role.Curator:
        return this.curator.surname +
            ' ' +
            this.curator.name +
            ' ' +
            this.curator.patronymic;
    }
  }

  String get phone {
    switch (this.role) {
      case Role.Administrator:
        return this.administrator.phone;
      case Role.Courier:
        return this.courier.phone;
      case Role.Curator:
        return this.curator.phone;
    }
  }

  void notify() => notifyListeners();
}
