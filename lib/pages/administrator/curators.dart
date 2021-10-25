import 'package:flutter/widgets.dart';
import 'package:topgo/api/curators.dart';
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
    return FutureBuilder<List<SimpleCurator>>(
      future: getCurators(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Error(text: snapshot.error!.toString());
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData)
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: 8,
                children: [
                  SizedBox(width: 12),
                  ...context
                      .watch<User>()
                      .administrator!
                      .shownCurators
                      .map((curator) => CuratorCard(curator: curator))
                      .toList(),
                  SizedBox(width: 8),
                ],
              ),
            ),
          );
        else
          return Loading();
      },
    );
  }
}
