import 'package:flutter/widgets.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/courier/history_card.dart';
import 'package:provider/provider.dart';

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
            ...context.watch<User>().courier.shownHistory.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: OrderHistoryCard(item: item),
                  ),
                ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
