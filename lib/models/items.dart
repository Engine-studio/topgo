import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/pages/administrator/curators.dart';
import 'package:topgo/pages/documents.dart';
import 'package:topgo/pages/courier/history.dart';
import 'package:topgo/pages/courier/orders.dart';
import 'package:topgo/pages/courier/profile.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/pages/curator/couriers.dart';
import 'package:topgo/pages/curator/finances.dart';
import 'package:topgo/pages/curator/profile.dart';
import 'package:topgo/pages/curator/restaurants.dart';
import 'package:topgo/styles.dart';

class Items {
  List<String> bottomNavBarIcons(BuildContext context) {
    switch (context.read<User>().role) {
      case Role.Courier:
        return [
          'history',
          'rocket',
          'user',
          'documents',
        ];
      case Role.Administrator:
        return [
          'users-alt',
          'store',
          'usd-circle',
          'suitcase-alt',
          'user-circle',
          'documents',
        ];
      case Role.Curator:
        return [
          'users-alt',
          'store',
          'usd-circle',
          'user-circle',
          'documents',
        ];
    }
  }

  List<Widget> bottomNavBarTabs(BuildContext context) {
    switch (context.read<User>().role) {
      case Role.Courier:
        return <Widget>[
          CourierHistoryTab(),
          CourierOrdersTab(),
          CourierProfileTab(),
          DocumentsTab(),
        ];
      case Role.Administrator:
        return <Widget>[
          CuratorAndAdminCouriersTab(),
          CuratorAndAdminRestaurantsTab(),
          CuratorAndAdminFinancesTab(),
          AdministratorCouratorsTab(),
          CuratorAndAdminProfileTab(),
          DocumentsTab(),
        ];
      case Role.Curator:
        return <Widget>[
          CuratorAndAdminCouriersTab(),
          CuratorAndAdminRestaurantsTab(),
          CuratorAndAdminFinancesTab(),
          CuratorAndAdminProfileTab(),
          DocumentsTab(),
        ];
    }
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
        return [
          AppBarItem(
            name: 'users-alt',
            title: 'Курьеры',
            withSearch: true,
          ),
          AppBarItem(
            name: 'store',
            title: 'Рестораны',
            withSearch: true,
          ),
          AppBarItem(
            name: 'usd-circle',
            title: 'Управление финансами',
            withSearch: true,
          ),
          AppBarItem(
            name: 'suitcase-alt',
            title: 'Кураторы',
            withSearch: true,
          ),
          AppBarItem(
            name: 'user-circle',
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
      case Role.Curator:
        return [
          AppBarItem(
            name: 'users-alt',
            title: 'Курьеры',
            withSearch: true,
            button: Container(
              margin: const EdgeInsets.only(right: 28),
              child: Image.asset(
                'assets/icons/plus.png',
                width: 24,
                height: 24,
                color: ClrStyle.lightBackground,
              ),
            ),
          ),
          AppBarItem(
            name: 'store',
            title: 'Рестораны',
            withSearch: true,
          ),
          AppBarItem(
            name: 'usd-circle',
            title: 'Управление финансами',
            withSearch: true,
          ),
          AppBarItem(
            name: 'user-circle',
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
