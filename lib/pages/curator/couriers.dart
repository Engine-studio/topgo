import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/curator/courier_card.dart';

class CuratorAndAdminCouriersTab extends StatelessWidget {
  const CuratorAndAdminCouriersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12),
            ...context.read<User>().role == Role.Curator
                ? context.watch<User>().curator.shownCouriers.map(
                      (courier) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: CourierCard(courier: courier),
                      ),
                    )
                : context.watch<User>().administrator.shownCouriers.map(
                      (courier) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: CourierCard(courier: courier),
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
