import 'package:flutter/widgets.dart';
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
      height: 208,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            AddressHolder(dist: 'Откуда:', address: order.fromAddress!),
            SizedBox(height: 8),
            AddressHolder(dist: 'Куда:', address: order.toAddress!),
            SizedBox(height: 18),
            OrderInfoHolder(
              time: order.total!,
              payment: order.withCash! ? 'Наличные' : 'Терминал',
              sum: order.sum!,
            ),
            SizedBox(height: 18),
            Row(
              children: [
                Flexible(
                  flex: 6,
                  child: Row(
                    children: [
                      Text('Внешний вид:', style: TxtStyle.smallText),
                      SizedBox(width: 8),
                      StarHolder(rating: order.appearance!),
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
                        timeString(order.start!),
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
                  flex: 6,
                  child: Row(
                    children: [
                      Text('Вежливость:', style: TxtStyle.smallText),
                      SizedBox(width: 8),
                      StarHolder(rating: order.behavior!),
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
                        timeString(order.stop!),
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
