import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:topgo/functions/send_notification.dart';
import 'package:topgo/models/items.dart';
import 'package:topgo/models/notification.dart' as notif;
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/appbar.dart';
import 'package:topgo/widgets/bottom_navbar.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentIndex = 0;
  Timer? timer;
  final Location _location = Location();
  List<notif.Notification> Function(LocationData)? notify;

  // TODO: implement polling
  void polling() async {
    print('polling');
    if (notify != null)
      notify!(await _location.getLocation())
          .map((not) => pushNotification(not));
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(minutes: 1), (Timer t) => polling());
  }

  @override
  Widget build(BuildContext context) {
    List<String> icons = Items().bottomNavBarIcons(context);
    List<Widget> tabs = Items().bottomNavBarTabs(context);
    List<AppBarItem> appBarItems = Items().appBarItems(context);
    return Scaffold(
      appBar: Appbar(
        appBarItem: appBarItems[currentIndex],
        onPressed: () {
          if (appBarItems[currentIndex].title == 'Профиль')
            setState(() {
              this.currentIndex = icons.length - 1;
            });
        },
      ),
      body: SafeArea(
        child: tabs[currentIndex],
      ),
      bottomNavigationBar: BottomNavBar(
        icons: icons.sublist(0, icons.length - 1),
        onPressed: (index) {
          context.read<User>().updateView('');
          setState(() {
            this.currentIndex = index;
          });
        },
      ),
    );
  }
}
