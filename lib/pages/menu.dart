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
import 'package:topgo/pages/administrator/curators.dart';
import 'package:topgo/pages/courier/history.dart';
import 'package:topgo/pages/courier/orders.dart';
import 'package:topgo/pages/courier/profile.dart';
import 'package:topgo/pages/curator/couriers.dart';
import 'package:topgo/pages/curator/finances.dart';
import 'package:topgo/pages/curator/profile.dart';
import 'package:topgo/pages/curator/restaurants.dart';
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
    try {
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
        } else
          await clearLocation(context);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void extraPolling() async {
    try {
      print('extra polling');
      print(thisContext!.read<User>().courier!.shift.toString());
      if (role == Role.Courier &&
          thisContext != null &&
          thisContext!.read<User>().courier!.shift != null &&
          [1, 2].contains(thisContext!.read<User>().courier!.orders.length)) {
        print('extra polling PASSED');
        LocationData locationData = await _location.getLocation();
        await sendLocation(thisContext!, locationData);
        OrderRequest orderRequest = OrderRequest.create(
          courierId: thisContext!.read<User>().id!,
          locationData: locationData,
        );
        thisContext!.read<User>().removeRequests();
        await getNewOrder(thisContext!, orderRequest);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    extra!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (role == null) role = context.read<User>().role;
    if (thisContext == null) thisContext = context;
    if (timer == null)
      timer = Timer.periodic(Duration(minutes: 1), (t) => polling());
    if (extra == null)
      extra = Timer.periodic(Duration(minutes: 5), (t) => extraPolling());
    List<String> icons = Items().bottomNavBarIcons(context);
    List<AppBarItem> appBarItems = Items().appBarItems(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Appbar(
        appBarItem: appBarItems[currentIndex],
        onPressed: () {},
      ),
      body: SafeArea(
        child: tab(currentIndex, role!),
      ),
      bottomNavigationBar: BottomNavBar(
        icons: icons,
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

Widget tab(int index, Role role) {
  if (role == Role.Courier)
    return index == 0
        ? CourierHistoryTab()
        : index == 1
            ? CourierOrdersTab()
            : CourierProfileTab();
  else {
    return index == 0
        ? CuratorAndAdminCouriersTab()
        : index == 1
            ? CuratorAndAdminRestaurantsTab()
            : index == 2
                ? CuratorAndAdminFinancesTab()
                : index == 3
                    ? (role == Role.Curator
                        ? CuratorAndAdminProfileTab()
                        : AdministratorCouratorsTab())
                    : CuratorAndAdminProfileTab();
  }
}
