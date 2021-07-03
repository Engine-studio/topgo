import 'package:flutter/widgets.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/curator/finance_card.dart';
import 'package:provider/provider.dart';

class CuratorAndAdminFinancesTab extends StatelessWidget {
  const CuratorAndAdminFinancesTab({Key? key}) : super(key: key);

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
                        child: FinanceCard(courier: courier),
                      ),
                    )
                : context.watch<User>().administrator.shownCouriers.map(
                      (courier) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: FinanceCard(courier: courier),
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
