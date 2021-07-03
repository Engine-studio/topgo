import 'package:flutter/widgets.dart';
import 'package:topgo/functions/time_string.dart';
import 'package:topgo/models/courier_history.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/address_holder.dart';
import 'package:topgo/widgets/courier/order_info_holder.dart';
import 'package:topgo/widgets/courier/star_holder.dart';

class OrderHistoryCard extends StatelessWidget {
  final CourierHistoryItem item;
  const OrderHistoryCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderBox(
      height: 208,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            AddressHolder(dist: 'Откуда:', address: item.from),
            SizedBox(height: 8),
            AddressHolder(dist: 'Куда:', address: item.to),
            SizedBox(height: 18),
            OrderInfoHolder(
              time: item.time,
              payment: item.payment,
              sum: item.sum,
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
                      StarHolder(rating: item.viewPoint),
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
                        timeString(item.timeFrom),
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
                      StarHolder(rating: item.behaviorPoint),
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
                        timeString(item.timeTo),
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
