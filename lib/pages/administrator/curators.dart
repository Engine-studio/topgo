import 'package:flutter/widgets.dart';
import 'package:topgo/models/simple_curator.dart';
import 'package:topgo/models/user.dart';
import 'package:provider/provider.dart';
import 'package:topgo/widgets/administrator/curator_card.dart';
import 'package:topgo/widgets/error.dart';
import 'package:topgo/widgets/loading.dart';

class AdministratorCouratorsTab extends StatelessWidget {
  const AdministratorCouratorsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<SimpleCurator>> curators = Future.value([]);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            FutureBuilder<List<SimpleCurator>>(
              future: curators,
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Error(text: snapshot.error!.toString());
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  context.read<User>().administrator!.curators = snapshot.data!;
                  return Wrap(
                    direction: Axis.vertical,
                    runSpacing: 8,
                    children: context
                        .watch<User>()
                        .administrator!
                        .shownCurators
                        .map((curator) => CuratorCard(curator: curator))
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
