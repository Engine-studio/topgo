import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/api/polling.dart';
import 'package:topgo/models/user.dart';
import 'package:provider/provider.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/courier/order_card.dart';
import 'package:topgo/widgets/error.dart';
import 'package:topgo/widgets/loading.dart';

class CourierOrdersTab extends StatelessWidget {
  const CourierOrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: pollOrders(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Error(text: snapshot.error!.toString());
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData)
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: context.watch<User>().courier!.ordersRequest.length == 0 &&
                    context.watch<User>().courier!.orders.length == 0
                ? Center(
                    child: Text(
                      'У вас нет заказов',
                      style: TxtStyle.mainHeader,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ...context.watch<User>().courier!.orders.map(
                              (order) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: OrderCard(order: order, request: false),
                              ),
                            ),
                        context.watch<User>().courier!.ordersRequest.length >
                                    0 &&
                                context.watch<User>().courier!.orders.length > 0
                            ? Divider(
                                thickness: 2,
                                color: Colors.black,
                              )
                            : SizedBox(),
                        ...context.watch<User>().courier!.ordersRequest.map(
                              (order) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: OrderCard(order: order, request: true),
                              ),
                            ),
                      ],
                    ),
                  ),
          );
        else
          return Loading();
      },
    );
  }
}
