import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          height: 111,
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
                        timeString(restaurant.open!) +
                            '  -  ' +
                            timeString(restaurant.close!),
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
                          builder: (_) {
                            return ChangeNotifierProvider.value(
                              value: Provider.of<User>(context, listen: false),
                              child: RestaurantDeletingDialog(),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 4),
                      // TODO: implement calling
                      ActionIcon(iconName: 'call', onTap: () => {}),
                    ],
                  ),
                ),
              ],
            ),
            // Row(
            //   children: [
            //     Container(
            //       width: 74,
            //       height: 74,
            //       decoration: BoxDecoration(shape: BoxShape.circle),
            //       clipBehavior: Clip.hardEdge,
            //       child: Image.network(
            //         courier.image,
            //         fit: BoxFit.fill,
            //       ),
            //     ),
            //     SizedBox(width: 15),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             courier.fullName,
            //             style: TxtStyle.selectedMainText,
            //           ),
            //           Spacer(),
            //           Row(
            //             crossAxisAlignment: CrossAxisAlignment.end,
            //             children: [
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(courier.phone, style: TxtStyle.smallText),
            //                   SizedBox(height: 8),
            //                   Row(
            //                     children: [
            //                       StarHolder(rating: courier.rating),
            //                       SizedBox(width: 16),
            //                       Image.asset(
            //                         courier.movement == 0
            //                             ? 'assets/icons/pedestrian.png'
            //                             : courier.movement == 1
            //                                 ? 'assets/icons/bicycle.png'
            //                                 : 'assets/icons/car.png',
            //                         height: 15,
            //                         color: ClrStyle.icons,
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //               Spacer(),
            //               //TODO: implement functions
            //               courier.action.contains('Заблокирован')
            //                   ? ActionIcon(
            //                       iconName: 'lock-alt',
            //                       accept: false,
            //                       onTap: () => {},
            //                     )
            //                   : ActionIcon(
            //                       iconName: 'lock-open-alt',
            //                       onTap: () => showDialog(
            //                         context: context,
            //                         builder: (_) {
            //                           return ChangeNotifierProvider.value(
            //                             value: Provider.of<User>(context,
            //                                 listen: false),
            //                             child: CourierBlockingDialog(),
            //                           );
            //                         },
            //                       ),
            //                     ),
            //               SizedBox(width: 4),
            //               ActionIcon(
            //                 iconName: 'trash-alt',
            //                 accept: false,
            //                 onTap: () => showDialog(
            //                   context: context,
            //                   builder: (_) {
            //                     return ChangeNotifierProvider.value(
            //                       value:
            //                           Provider.of<User>(context, listen: false),
            //                       child: CourierDeletingDialog(),
            //                     );
            //                   },
            //                 ),
            //               ),
            //               SizedBox(width: 4),
            //               // TODO: implement calling
            //               ActionIcon(iconName: 'call', onTap: () => {}),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ),
      ],
    );
  }
}
