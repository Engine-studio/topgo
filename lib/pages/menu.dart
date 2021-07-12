import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:topgo/api/notifications.dart';
import 'package:topgo/main.dart';
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
  BuildContext? thisContext;
  Role? role;

  // TODO: implement polling
  void polling() async {
    print('polling');
    // TODO: implement sharing location
    // if (role == Role.Courier)
    //   sendLocation(context, await _location.getLocation());
    // TODO: wait Artem to bug fix
    // List<notif.Notification> notifications =
    //     thisContext != null ? await getNotifications(thisContext!) : [];
    // for (notif.Notification notification in notifications)
    //   showNotification(notification);
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => polling());
  }

  @override
  Widget build(BuildContext context) {
    role = context.read<User>().role;
    thisContext = context;
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
