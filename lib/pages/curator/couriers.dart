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

class CuratorAndAdminCouriersTab extends StatefulWidget {
  const CuratorAndAdminCouriersTab({Key? key}) : super(key: key);

  @override
  _CuratorAndAdminCouriersTabState createState() =>
      _CuratorAndAdminCouriersTabState();
}

class _CuratorAndAdminCouriersTabState
    extends State<CuratorAndAdminCouriersTab> {
  late Future<List<SimpleCourier>> _future;

  @override
  void initState() {
    super.initState();
    _future = getCouriers(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SimpleCourier>>(
      future: _future,
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
                  MapCard(
                      markers: shown
                          .map((courier) => MapMarker.courier(courier: courier))
                          .toList()),
                  ...shown
                      .map((courier) => CourierCard(courier: courier))
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
