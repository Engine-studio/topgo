import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/api/work.dart';
import 'package:topgo/models/order.dart';
import 'package:topgo/models/restaurant.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/simple_curator.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/address_holder.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/courier/order_info_holder.dart';
import 'package:topgo/widgets/courier/problem_dialog.dart';
import 'package:topgo/widgets/flag.dart';
import 'package:topgo/widgets/map/map_card.dart';
import 'package:topgo/widgets/map/map_marker.dart';
import 'package:topgo/api/orders.dart' as api;
import 'package:provider/provider.dart';
import 'package:topgo/models/user.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final bool request;
  const OrderCard({
    Key? key,
    required this.order,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SimpleCurator curator;
    return Container(
      child: Column(
        children: [
          this.request
              ? Flag(text: 'Новый заказ', gradient: GrdStyle.panel)
              : Flag(text: 'Вы выполняете сейчас', gradient: GrdStyle.accept),
          SizedBox(height: 8),
          MapCard(
            expanded: false,
            text: '№${order.id}',
            markers: [
              MapMarker.restaurant(
                restaurant: Restaurant.simple(
                  x: order.fromLatLng!.latitude,
                  y: order.fromLatLng!.longitude,
                ),
              ),
              MapMarker.courier(
                courier: SimpleCourier.simple(
                  x: order.toLatLng!.latitude,
                  y: order.toLatLng!.longitude,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          BorderBox(
            height: 118,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  AddressHolder(dist: 'Откуда:', address: order.fromAddress!),
                  SizedBox(height: 8),
                  AddressHolder(dist: 'Куда:', address: order.toAddress!),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          OrderInfoHolder(
            time: order.total!,
            payment: order.withCash.toString(),
            sum: order.sum!,
          ),
          SizedBox(height: 16),
          this.request
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 165,
                      child: Button(
                        text: 'Принять',
                        buttonType: ButtonType.Accept,
                        onPressed: () async => {
                          context.read<User>().removeRequest(order),
                          if (await api.acceptOrder(context, order))
                            api.getCurrentOrders(context),
                        },
                      ),
                    ),
                    SizedBox(
                      width: 165,
                      child: Button(
                        text: 'Отказаться',
                        buttonType: ButtonType.Decline,
                        filled: false,
                        onPressed: () async => {
                          context.read<User>().removeRequest(order),
                          if (await api.declineOrder(context, order))
                            api.getCurrentOrders(context),
                        },
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    order.status != OrderStatus.Delivering
                        ? Button(
                            text: 'Забрал',
                            buttonType: ButtonType.Panel,
                            onPressed: () async => {
                              if (await api.pickOrder(context, order))
                                api.getCurrentOrders(context),
                            },
                          )
                        : Button(
                            text: 'Доставил',
                            buttonType: ButtonType.Panel,
                            onPressed: () async => {
                              if (await api.deliverOrder(context, order))
                                api.getCurrentOrders(context),
                            },
                          ),
                    SizedBox(height: 8),
                    Button(
                      text: 'ЧП',
                      buttonType: ButtonType.Decline,
                      filled: false,
                      onPressed: () async => {
                        curator = await callHelper(context),
                        showDialog(
                          context: context,
                          builder: (_) => ProblemDialog(curator: curator),
                        )
                      },
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
