import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topgo/functions/launcher.dart';
import 'package:topgo/functions/phone_string.dart';
import 'package:topgo/functions/time_string.dart';
import 'package:topgo/models/restaurant.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/address_holder.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/curator/action_icon.dart';
import 'package:topgo/widgets/flag.dart';
import 'package:topgo/widgets/curator/restaurant_deleting_dialog.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final bool forMap;
  const RestaurantCard({
    Key? key,
    required this.restaurant,
    this.forMap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _flag = this.forMap
        ? Flag(
            text: restaurant.name!,
            gradient: GrdStyle.select,
          )
        : Flag(text: restaurant.name!, gradient: GrdStyle.button);
    return Column(
      children: [
        _flag,
        SizedBox(height: 8),
        BorderBox(
          height: 101,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              children: [
                AddressHolder(dist: 'Адрес', address: restaurant.address!),
                Spacer(),
                SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      Text(
                        timeString(restaurant.open![0]) +
                            '  -  ' +
                            timeString(restaurant.close![0]),
                        style: TxtStyle.smallText,
                      ),
                      Spacer(),
                      Text(
                        phoneString(restaurant.phone!),
                        style: TxtStyle.smallText,
                      ),
                      Spacer(flex: 3),
                      ActionIcon(
                        iconName: 'trash-alt',
                        accept: false,
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) {
                            return ChangeNotifierProvider.value(
                              value: Provider.of<User>(context, listen: false),
                              child: RestaurantDeletingDialog(
                                restaurant: restaurant,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 4),
                      ActionIcon(
                        iconName: 'call',
                        onTap: () async => call(restaurant.phone!),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
