import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/pages/courier/documents.dart';
import 'package:topgo/pages/courier/history.dart';
import 'package:topgo/pages/courier/orders.dart';
import 'package:topgo/pages/courier/profile.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';

class Items {
  List<String> bottomNavBarIcons(BuildContext context) {
    return [
      'history',
      'rocket',
      'user',
      'documents',
    ];
  }

  List<Widget> bottomNavBarTabs(BuildContext context) {
    return <Widget>[
      CourierHistoryTab(),
      CourierOrdersTab(),
      CourierProfileTab(),
      CourierDocumentsTab(),
    ];
  }

  List<AppBarItem> appBarItems(BuildContext context) {
    switch (context.read<User>().role) {
      case Role.Courier:
        return [
          AppBarItem(
            name: 'history',
            title: 'История',
            withSearch: true,
            searchHelpers: ['По дате', 'По адресу'],
          ),
          AppBarItem(name: 'rocket', title: 'Заказы'),
          AppBarItem(
            name: 'user',
            title: 'Профиль',
            button: Container(
              margin: const EdgeInsets.only(right: 28),
              child: Image.asset(
                'assets/icons/file-text.png',
                width: 24,
                height: 24,
                color: ClrStyle.lightBackground,
              ),
            ),
          ),
          AppBarItem(
            name: 'documents',
            title: 'Отчеты',
            button: Container(
              margin: const EdgeInsets.only(right: 28),
              child: Image.asset(
                'assets/icons/file-text.png',
                width: 24,
                height: 24,
                color: ClrStyle.lightBackground,
              ),
            ),
          ),
        ];
      case Role.Administrator:
        return [];
      case Role.Curator:
        return [];
    }
  }
}

class AppBarItem {
  String name;
  String title;
  bool withSearch;
  List<String> searchHelpers;
  Widget button;

  AppBarItem({
    required this.name,
    required this.title,
    this.withSearch = false,
    this.searchHelpers = const [],
    this.button = const SizedBox(),
  });
}
