import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:topgo/api/restaurants.dart';
import 'package:topgo/models/restaurant.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/curator/restaurant_card.dart';
import 'package:topgo/widgets/error.dart';
import 'package:topgo/widgets/loading.dart';
import 'package:topgo/widgets/map/map_card.dart';
import 'package:topgo/widgets/map/map_marker.dart';

class CuratorAndAdminRestaurantsTab extends StatelessWidget {
  const CuratorAndAdminRestaurantsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: getRestaurants(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Error(text: snapshot.error!.toString());
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          List<Restaurant> shown = context.watch<User>().shownRestaurants;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: 8,
                children: [
                  SizedBox(width: 12),
                  MapCard(
                    markers: shown
                        .map((restaurant) =>
                            MapMarker.restaurant(restaurant: restaurant))
                        .toList(),
                  ),
                  ...shown
                      .map((restaurant) =>
                          RestaurantCard(restaurant: restaurant))
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
