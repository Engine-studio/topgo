import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/user.dart';
import 'package:provider/provider.dart';
import 'package:topgo/widgets/courier/order_card.dart';

class CourierOrdersTab extends StatelessWidget {
  const CourierOrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...context.watch<User>().courier!.orders.map(
                  (order) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: OrderCard(order: order, request: false),
                  ),
                ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            ...context.watch<User>().courier!.ordersRequest.map(
                  (order) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: OrderCard(order: order, request: true),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
