import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:topgo/api/polling.dart';
import 'package:topgo/main.dart';
import 'package:topgo/models/items.dart';
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
import 'package:background_fetch/background_fetch.dart';

final fetchConfig = BackgroundFetchConfig(
  minimumFetchInterval: 15,
  forceAlarmManager: false,
  stopOnTerminate: false,
  startOnBoot: false,
  enableHeadless: true,
  requiresBatteryNotLow: false,
  requiresCharging: false,
  requiresStorageNotLow: false,
  requiresDeviceIdle: false,
  requiredNetworkType: NetworkType.NONE,
);

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int? currentIndex;
  bool? threaded;
  Timer? timer, extra;
  final Location _location = Location();
  BuildContext? thisContext;

  void polling() async {
    print('POLLING');
    try {
      await pollSelfData(thisContext!);
      await pollNotifications(thisContext!);
      await pollOrders(thisContext!);
      await getOrder(thisContext!, _location, extra: false);
    } catch (e) {
      print('POLLING ERR: ' + e.toString());
    }
  }

  void extraPolling() async {
    print('EXTRA POLLING');
    try {
      await getOrder(thisContext!, _location, extra: true);
    } catch (e) {
      print('EXTRA POLLING ERR: ' + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      print('Android detected');
      try {
        BackgroundFetch.configure(
          fetchConfig,
          fetchFunctionFirst,
        );
        print('task created');
      } catch (e) {
        print('task wasnt created: ${e.toString()}');
      }
    }
  }

  void fetchFunctionFirst(String taskId) {
    print('fetch func');
    if (mounted) {
      print('execution');
      // showNotification(
      //   not.Notification.create(title: "Title", message: "Message"),
      // );
      polling();
      // setState(() {
      //   _events.insert(0, "$taskId@${timestamp.toString()}  [НА ЭКРАНЕ 1 SET]");
      // });
    }

    BackgroundFetch.finish(taskId);

    if (taskId == 'flutter_background_fetch') {
      return;
    }

    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: taskId,
        delay: taskDelay,
        periodic: false,
        forceAlarmManager: true,
        stopOnTerminate: false,
        enableHeadless: true,
        requiresNetworkConnectivity: true,
        requiresCharging: true));
  }

  void _startSheduleTask1() {
    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: '1111',
        delay: taskDelay,
        periodic: false,
        forceAlarmManager: true,
        stopOnTerminate: false,
        enableHeadless: true,
        requiresNetworkConnectivity: true,
        requiresCharging: true));
  }

  void _stopTasks() {
    BackgroundFetch.stop();
  }

  @override
  Widget build(BuildContext context) {
    thisContext = context;

    Role role = context.read<User>().role!;

    if (currentIndex == null) currentIndex = role == Role.Courier ? 2 : 0;

    if (role == Role.Courier) {
      if (Platform.isAndroid && threaded != true) {
        _startSheduleTask1();
        threaded = true;
      } else if (Platform.isIOS) {
        if (timer == null)
          timer = Timer.periodic(
            Duration(seconds: 30),
            (t) => {if (thisContext != null) polling()},
          );
        if (extra == null)
          extra = Timer.periodic(
            Duration(minutes: 3),
            (t) => {if (thisContext != null) extraPolling()},
          );
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Appbar(
        appBarItem: Items().appBarItems(context)[currentIndex!],
        onPressed: () {},
      ),
      body: SafeArea(
        child: tab(currentIndex!, role),
      ),
      bottomNavigationBar: BottomNavBar(
        icons: Items().bottomNavBarIcons(context),
        onPressed: (index) {
          context.read<User>().updateView('');
          setState(() {
            this.currentIndex = index;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    print('dispose');

    if (Platform.isAndroid) {
      _stopTasks();
    } else if (Platform.isIOS) {
      if (timer != null) timer!.cancel();
      if (extra != null) extra!.cancel();
    }
    super.dispose();
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
