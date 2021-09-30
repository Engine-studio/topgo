import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:topgo/api/general.dart';
import 'package:topgo/api/notifications.dart';
import 'package:topgo/api/orders.dart';
import 'package:topgo/api/work.dart';
import 'package:topgo/main.dart';
import 'package:topgo/models/courier.dart';
import 'package:topgo/models/items.dart';
import 'package:topgo/models/notification.dart' as notif;
import 'package:topgo/models/order.dart';
import 'package:topgo/models/simple_courier.dart';
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
  int? currentIndex;
  Timer? timer, extra;
  final Location _location = Location();
  BuildContext? thisContext;

  void polling() async {
    print('POLLING');
    try {
      await pollSelfData(thisContext!);
      await pollNotifications(thisContext!);
      await pollOrders(thisContext!);
      await getOrder(thisContext!, extra: false);
    } catch (e) {
      print('POLLING ERR: ' + e.toString());
    }
  }

  Future<void> pollOrders(BuildContext context) async {
    if (context.read<User>().courier!.shift != null) {
      List<Order> pOrders = context.read<User>().courier!.orders;
      List<Order> pHistory = context.read<User>().courier!.history;
      await getCurrentOrders(thisContext!);
      await getOrdersHistory(thisContext!);
      List<Order> orders = context.read<User>().courier!.orders;
      List<Order> history = context.read<User>().courier!.history;

      for (Order order in pOrders) {
        if (order.status == OrderStatus.Cooking)
          for (Order actual in orders)
            if (order.id == actual.id &&
                actual.status == OrderStatus.ReadyForDelivery)
              showNotification(notif.Notification.create(
                title: "Заказ готов",
                message: "Заказ #${actual.id} готов к доставке!",
              ));
      }

      if (orders.length < pOrders.length && history.length == pHistory.length) {
        bool found;
        for (Order order in pOrders) {
          found = false;
          for (Order actual in orders) if (actual.id == order.id) found = true;
          if (!found)
            showNotification(notif.Notification.create(
              title: "Заказ отменен",
              message: "Заказ #${order.id} был отменен!",
            ));
        }
      }
    }
  }

  void extraPolling() async {
    print('EXTRA POLLING');
    try {
      await getOrder(thisContext!, extra: true);
    } catch (e) {
      print('EXTRA POLLING ERR: ' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    thisContext = context;

    if (currentIndex == null)
      currentIndex = context.read<User>().role == Role.Courier ? 2 : 0;

    if (context.read<User>().role == Role.Courier) {
      if (timer == null)
        timer = Timer.periodic(
          Duration(seconds: 60),
          (t) => {if (thisContext != null) polling()},
        );
      if (extra == null)
        extra = Timer.periodic(
          Duration(seconds: 180),
          (t) => {if (thisContext != null) extraPolling()},
        );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Appbar(
        appBarItem: Items().appBarItems(context)[currentIndex!],
        onPressed: () {},
      ),
      body: SafeArea(
        child: tab(currentIndex!, context.read<User>().role!),
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
    if (timer != null) timer!.cancel();
    if (extra != null) extra!.cancel();
    super.dispose();
  }

  Future<void> pollSelfData(BuildContext context) async {
    User pSelf = context.read<User>();
    Courier pCourier = pSelf.courier!;
    await logInAgain(context);
    User self = context.read<User>();
    Courier courier = self.courier!;

    if (courier.deleted) {
      showNotification(notif.Notification.create(
        title: "Удаление",
        message: "Вас удалили!",
      ));
      self.logOut(context);
    }

    if (pCourier.blocked != courier.blocked)
      courier.blocked
          ? showNotification(notif.Notification.create(
              title: "Блокировка",
              message: "Вас заблокировали!",
            ))
          : showNotification(notif.Notification.create(
              title: "Снятие блокировки",
              message: "Вас разблокировали!",
            ));
  }

  Future<LocationData> processLocation(BuildContext context) async {
    LocationData locationData = await _location.getLocation();

    if ((locationData.speed ?? 0) * 3.6 >= 80)
      showNotification(notif.Notification.create(
        title: "Соблюдайте скоростной режим!",
        message: "Уважаемый курьер, вы движетесь со скоростью более 80 км/час.",
      ));

    await clearLocation(thisContext!);
    await sendLocation(thisContext!, locationData);
    return locationData;
  }

  Future<void> pollNotifications(BuildContext context) async {
    List<notif.Notification> notifications =
        await getNotifications(thisContext!);
    for (notif.Notification notification in notifications)
      showNotification(notification);
  }

  Future<void> getOrder(
    BuildContext context, {
    required bool extra,
  }) async {
    User self = context.read<User>();
    Courier selfCourier = self.courier!;

    if (selfCourier.shift != null) {
      OrderRequest orderRequest = OrderRequest.create(
        courierId: self.id!,
        locationData: await processLocation(context),
      );

      int pCount = selfCourier.ordersRequest.length;
      List<Order> orders;

      if (extra && [1, 2].contains(selfCourier.orders.length)) {
        context.read<User>().removeRequests();

        await getNewOrder(context, orderRequest);
        orders = context.read<User>().courier!.ordersRequest;
        if (pCount != orders.length)
          showNotification(notif.Notification.create(
            title: "У вас новый дополнительный заказ!",
            message: "Обратите внимание на заказ #${orders.last.id}",
          ));
      }

      if (!extra && selfCourier.orders.length == 0) {
        await getNewOrder(context, orderRequest);
        orders = context.read<User>().courier!.ordersRequest;
        if (pCount != orders.length)
          showNotification(notif.Notification.create(
            title: "У вас новый заказ!",
            message: "Обратите внимание на заказ #${orders.last.id}",
          ));
      }
    }
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
