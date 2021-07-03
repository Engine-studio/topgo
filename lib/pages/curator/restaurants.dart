import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/restaurant.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/curator/restaurant_card.dart';
import 'package:topgo/widgets/error.dart';
import 'package:topgo/widgets/loading.dart';

class CuratorAndAdminRestaurantsTab extends StatelessWidget {
  const CuratorAndAdminRestaurantsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<Restaurant>> restaurants = Future.value([]);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            FutureBuilder<List<Restaurant>>(
              future: restaurants,
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Error(text: snapshot.error!.toString());
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  context.read<User>().restaurants = snapshot.data!;
                  return Wrap(
                    direction: Axis.vertical,
                    runSpacing: 8,
                    children: context
                        .watch<User>()
                        .shownRestaurants
                        .map((restaurant) =>
                            RestaurantCard(restaurant: restaurant))
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
