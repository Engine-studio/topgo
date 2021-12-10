import 'package:flutter/widgets.dart';
import 'package:topgo/functions/money_string.dart';
import 'package:topgo/functions/time_string.dart';
import 'package:topgo/models/order.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/address_holder.dart';
import 'package:topgo/widgets/courier/order_info_holder.dart';
import 'package:topgo/widgets/courier/star_holder.dart';

class OrderHistoryCard extends StatelessWidget {
  final Order order;
  const OrderHistoryCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderBox(
      height: 302,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            AddressHolder(
              dist: 'Откуда:',
              address: order.fromAddress ?? 'Not found',
            ),
            SizedBox(height: 8),
            AddressHolder(
              dist: 'Куда:',
              address: order.toAddress ?? 'Not found',
            ),
            SizedBox(height: 8),
            AddressHolder(
              dist: 'Коммент:',
              address: order.comment ?? 'Not found',
            ),
            SizedBox(height: 8),
            AddressHolder(
              dist: 'Доставка:',
              address: order.courierShare != null
                  ? moneyString(order.courierShare!)
                  : 'Not found',
            ),
            SizedBox(height: 8),
            OrderInfoHolder(
              time: order.total ?? 0,
              payment: order.withCash!,
              sum: order.sum ?? 0,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: Row(
                    children: [
                      Text('Внешний вид:', style: TxtStyle.smallText),
                      SizedBox(width: 8),
                      StarHolder(rating: order.appearance ?? 0),
                    ],
                  ),
                ),
                Spacer(),
                Flexible(
                  flex: 4,
                  child: Row(
                    children: [
                      Text('Получен:', style: TxtStyle.smallText),
                      SizedBox(width: 8),
                      Text(
                        timeString(order.start ?? [0, 0]),
                        style: TxtStyle.smallText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: Row(
                    children: [
                      Text('Вежливость:', style: TxtStyle.smallText),
                      SizedBox(width: 8),
                      StarHolder(rating: order.behavior ?? 0),
                    ],
                  ),
                ),
                Spacer(),
                Flexible(
                  flex: 4,
                  child: Row(
                    children: [
                      Text('Доставлен:', style: TxtStyle.smallText),
                      SizedBox(width: 8),
                      Text(
                        timeString(order.stop ?? [0, 0]),
                        style: TxtStyle.smallText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
