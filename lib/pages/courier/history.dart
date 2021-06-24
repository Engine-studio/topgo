import 'package:flutter/widgets.dart';
import 'package:topgo/models/courier_history.dart';
import 'package:topgo/widgets/courier/history_card.dart';

class CourierHistoryTab extends StatelessWidget {
  const CourierHistoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            ...CourierHistoryItem(
              from: 'Проспект 60-летия Октября, дом 11, корпус 3, строение 1 ' +
                  'подъезд 2, квартира 64 и дальше тоже текст',
              to: 'Проспект 60-летия Октября, дом 11, корпус 3, строение 1 ' +
                  'подъезд 2, квартира 64 и дальше тоже текст',
              time: 5,
              payment: 'терминал',
              sum: 10000,
              viewPoint: 4.5,
              behaviorPoint: 4.5,
              timeFrom: [12, 30],
              timeTo: [13, 10],
            ).example.map(
                  (item) => HistoryCard(item: item),
                ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
