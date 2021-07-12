import 'package:flutter/widgets.dart';
import 'package:topgo/api/couriers.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/curator/finance_card.dart';
import 'package:provider/provider.dart';
import 'package:topgo/widgets/error.dart';
import 'package:topgo/widgets/loading.dart';

class CuratorAndAdminFinancesTab extends StatelessWidget {
  const CuratorAndAdminFinancesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SimpleCourier>>(
      future: getCouriers(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Error(text: snapshot.error!.toString());
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          List<SimpleCourier> shown = context.watch<User>().shownCouriers;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: 8,
                children: [
                  SizedBox(width: 12),
                  ...shown
                      .map(
                        (courier) => FinanceCard(
                            key: Key(courier.id!.toString()), courier: courier),
                      )
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
