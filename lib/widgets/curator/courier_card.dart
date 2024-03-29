import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:topgo/api/couriers.dart';
import 'package:topgo/functions/launcher.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/courier/star_holder.dart';
import 'package:topgo/widgets/curator/action_icon.dart';
import 'package:topgo/widgets/curator/courier_blocking_dialog.dart';
import 'package:topgo/widgets/curator/courier_deleting_dialog.dart';
import 'package:topgo/widgets/flag.dart';

class CourierCard extends StatelessWidget {
  final SimpleCourier courier;
  final bool forMap;
  const CourierCard({
    Key? key,
    required this.courier,
    this.forMap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _flag = this.forMap
        ? Flag(
            text: courier.action ?? '',
            gradient: GrdStyle.select,
          )
        : Flag(text: courier.action ?? '');
    return Column(
      children: [
        _flag,
        SizedBox(height: 8),
        BorderBox(
          height: 112,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(courier.photo, fit: BoxFit.fill),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courier.fullName,
                        style: TxtStyle.selectedMainText,
                      ),
                      Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(courier.phone, style: TxtStyle.smallText),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  StarHolder(rating: courier.rating!),
                                  SizedBox(width: 16),
                                  Image.asset(
                                    courier.movement == 0
                                        ? 'assets/icons/pedestrian.png'
                                        : courier.movement == 1
                                            ? 'assets/icons/bicycle.png'
                                            : 'assets/icons/car.png',
                                    height: 15,
                                    color: ClrStyle.icons,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          courier.blocked ?? false
                              ? ActionIcon(
                                  iconName: 'lock-alt',
                                  accept: false,
                                  onTap: () async => {
                                    if (await blockUnblockCourier(
                                        context, courier))
                                      context
                                          .read<User>()
                                          .blockUnblockCourier(courier),
                                  },
                                )
                              : ActionIcon(
                                  iconName: 'lock-open-alt',
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ChangeNotifierProvider.value(
                                        value: Provider.of<User>(context,
                                            listen: false),
                                        child: CourierBlockingDialog(
                                          courier: courier,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          SizedBox(width: 4),
                          ActionIcon(
                            iconName: 'trash-alt',
                            accept: false,
                            onTap: () => showDialog(
                              context: context,
                              builder: (context) {
                                return ChangeNotifierProvider.value(
                                  value:
                                      Provider.of<User>(context, listen: false),
                                  child:
                                      CourierDeletingDialog(courier: courier),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 4),
                          ActionIcon(
                            iconName: 'call',
                            onTap: () async => call(courier.phoneSource!),
                          ),
                        ],
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
