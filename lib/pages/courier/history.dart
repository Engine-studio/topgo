import 'package:flutter/widgets.dart';
import 'package:topgo/api/orders.dart';
import 'package:topgo/models/order.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/courier/history_card.dart';
import 'package:provider/provider.dart';
import 'package:topgo/widgets/error.dart';
import 'package:topgo/widgets/loading.dart';

class CourierHistoryTab extends StatelessWidget {
  const CourierHistoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>>(
      future: getOrdersHistory(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Error(text: snapshot.error!.toString());
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          List<Order> shown = context.watch<User>().shownHistory;
          shown.sort((a, b) => b.id!.compareTo(a.id!));
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: 8,
                children: [
                  SizedBox(width: 12),
                  ...shown
                      .map((order) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: OrderHistoryCard(order: order),
                          ))
                      .toList(),
                  SizedBox(width: 8),
                ],
              ),
            ),
          );
        } else
          return Loading();
      },
    );
  }
}
