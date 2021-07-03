import 'package:flutter/widgets.dart';
import 'package:topgo/models/user.dart';
import 'package:provider/provider.dart';
import 'package:topgo/widgets/administrator/curator_card.dart';

class AdministratorCouratorsTab extends StatelessWidget {
  const AdministratorCouratorsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12),
            ...context.watch<User>().administrator.shownCurators.map(
                  (curator) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: CuratorCard(curator: curator),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
