import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:topgo/api/notifications.dart';
import 'package:topgo/api/orders.dart';
import 'package:topgo/api/work.dart';
import 'package:topgo/main.dart';
import 'package:topgo/models/items.dart';
import 'package:topgo/models/notification.dart' as notif;
import 'package:topgo/models/order.dart';
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
  Timer? timer, extra;
  final Location _location = Location();
  BuildContext? thisContext;
  Role? role;

  void polling() async {
    print('polling');
    if (role == Role.Courier && thisContext != null) {
      List<notif.Notification> notifications =
          thisContext != null ? await getNotifications(thisContext!) : [];
      for (notif.Notification notification in notifications)
        showNotification(notification);
      if (thisContext!.read<User>().courier!.shift != null) {
        LocationData locationData = await _location.getLocation();
        await sendLocation(thisContext!, locationData);
        OrderRequest orderRequest = OrderRequest.create(
          courierId: thisContext!.read<User>().id!,
          locationData: locationData,
        );
        if (thisContext!.read<User>().courier!.orders.length == 0)
          await getNewOrder(thisContext!, orderRequest);
      }
    }
  }

  void extraPolling() async {
    print('extra polling');
    if (role == Role.Courier &&
        thisContext != null &&
        thisContext!.read<User>().courier!.shift != null &&
        [1, 2].contains(thisContext!.read<User>().courier!.orders.length)) {
      LocationData locationData = await _location.getLocation();
      await sendLocation(thisContext!, locationData);
      OrderRequest orderRequest = OrderRequest.create(
        courierId: thisContext!.read<User>().id!,
        locationData: locationData,
      );
      await getNewOrder(thisContext!, orderRequest);
    }
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(minutes: 1), (Timer t) => polling());
    extra = Timer.periodic(Duration(minutes: 10), (Timer t) => extraPolling());
  }

  @override
  void dispose() {
    timer!.cancel();
    extra!.cancel();
    super.dispose();
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
