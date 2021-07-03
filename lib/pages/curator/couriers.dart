import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/curator/courier_card.dart';
import 'package:topgo/widgets/error.dart';
import 'package:topgo/widgets/loading.dart';

class CuratorAndAdminCouriersTab extends StatelessWidget {
  const CuratorAndAdminCouriersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<SimpleCourier>> couriers = Future.value([]);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            FutureBuilder<List<SimpleCourier>>(
              future: couriers,
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Error(text: snapshot.error!.toString());
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  context.read<User>().couriers = snapshot.data!;
                  return Wrap(
                    direction: Axis.vertical,
                    runSpacing: 8,
                    children: context
                        .watch<User>()
                        .shownCouriers
                        .map((courier) => CourierCard(courier: courier))
                        .toList(),
                  );
                } else
                  return Loading();
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
