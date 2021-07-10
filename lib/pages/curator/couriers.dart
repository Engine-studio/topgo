import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:topgo/api/couriers.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/curator/courier_card.dart';
import 'package:topgo/widgets/error.dart';
import 'package:topgo/widgets/loading.dart';
import 'package:topgo/widgets/map/map_card.dart';
import 'package:topgo/widgets/map/map_marker.dart';

class CuratorAndAdminCouriersTab extends StatelessWidget {
  const CuratorAndAdminCouriersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FutureBuilder<List<SimpleCourier>>(
        future: getCouriers(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Error(text: snapshot.error!.toString());
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            context.read<User>().couriers = snapshot.data!;
            return Wrap(
              direction: Axis.horizontal,
              runSpacing: 8,
              children: [
                SizedBox(width: 12),
                MapCard(
                  markers: context
                      .watch<User>()
                      .shownCouriers
                      .map((courier) => MapMarker.courier(courier: courier))
                      .toList(),
                ),
                ...context
                    .watch<User>()
                    .shownCouriers
                    .map((courier) => CourierCard(courier: courier))
                    .toList(),
                SizedBox(width: 8),
              ],
            );
          } else
            return Loading();
        },
      ),
    );
  }
}
