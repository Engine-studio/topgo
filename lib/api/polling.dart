import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:topgo/api/general.dart';
import 'package:topgo/api/notifications.dart';
import 'package:topgo/api/orders.dart';
import 'package:topgo/api/work.dart';
import 'package:topgo/main.dart';
import 'package:topgo/pages/menu.dart' as menu;
import 'package:topgo/models/courier.dart';
import 'package:topgo/models/order.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/user.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/notification.dart' as notif;
import 'dart:developer';

Future<bool> pollSelfData(BuildContext context) async {
  print('pollSelfData');
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

  return self.logined;
}

Future<bool> processLocation(BuildContext context, Location location) async {
  print("Started checking location");
  LocationData locationData = await location.getLocation();
  print("Finished checking location");

  menu.currentLocation = locationData;

  if ((locationData.speed ?? 0) * 3.6 >= 80)
    showNotification(notif.Notification.create(
      title: "Соблюдайте скоростной режим!",
      message: "Уважаемый курьер, вы движетесь со скоростью более 80 км/час.",
    ));

  await clearLocation(context);
  await sendLocation(context, locationData);

  return true;
}

Future<void> pollNotifications(BuildContext context) async {
  print('pollNotifications');
  List<notif.Notification> notifications = await getNotifications(context);
  for (notif.Notification notification in notifications)
    showNotification(notification);
}

Future<void> getOrder(
  BuildContext context, {
  required bool extra,
}) async {
  print('getOrder');
  User self = context.read<User>();
  Courier selfCourier = self.courier!;

  LocationData loc = menu.currentLocation;

  if (selfCourier.shift != null) {
    OrderRequest orderRequest = OrderRequest.create(
      courierId: self.id!,
      locationData: loc,
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

Future<bool> pollOrders(BuildContext context) async {
  print('pollOrders');

  if (savedOrders == null || savedHistory == null) {
    await getCurrentOrders(context);
    await getOrdersHistory(context);
  } else {
    List<Order> pOrders = savedOrders!;
    print("previous:");
    print(inspect(pOrders));
    List<Order> pHistory = savedHistory!;
    await getCurrentOrders(context);
    await getOrdersHistory(context);
    List<Order> orders = context.read<User>().courier!.orders;
    print("current:");
    print(inspect(orders));
    List<Order> history = context.read<User>().courier!.history;

    for (Order order in pOrders) {
      if (order.status == OrderStatus.Cooking)
        for (Order actual in orders)
          if (order.id == actual.id &&
              actual.status == OrderStatus.ReadyForDelivery) {
            print("Заказ #${actual.id} готов к доставке!");
            showNotification(notif.Notification.create(
              title: "Заказ готов",
              message: "Заказ #${actual.id} готов к доставке!",
            ));
          }
    }

    bool found;
    for (Order order in pOrders) {
      found = false;
      for (Order actual in orders) if (actual.id == order.id) found = true;
      if (!found)
        for (Order hist in history)
          if (hist.id == order.id) if (![
            OrderStatus.Success,
            OrderStatus.Delivered
          ].contains(hist.status)) {
            print("Заказ #${order.id} был отменен!");
            showNotification(notif.Notification.create(
              title: "Заказ отменен",
              message: "Заказ #${order.id} был отменен!",
            ));
          }
    }
  }

  return true;
}
