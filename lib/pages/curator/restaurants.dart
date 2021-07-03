import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/curator/restaurant_card.dart';

class CuratorAndAdminRestaurantsTab extends StatelessWidget {
  const CuratorAndAdminRestaurantsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12),
            ...context.read<User>().role == Role.Curator
                ? context.watch<User>().curator.shownRestaurants.map(
                      (restaurant) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: RestaurantCard(
                          restaurant: restaurant,
                        ),
                      ),
                    )
                : context.watch<User>().administrator.shownRestaurants.map(
                      (restaurant) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: RestaurantCard(
                          restaurant: restaurant,
                        ),
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
