import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/money_holder.dart';
import 'package:topgo/widgets/courier/movement_selection.dart';
import 'package:topgo/widgets/courier/profile_card.dart';
import 'package:topgo/widgets/courier/start_work_dialog.dart';
import 'package:topgo/widgets/courier/stop_work_dialog.dart';
import 'package:topgo/widgets/courier/time_holder.dart';

class CourierProfileTab extends StatelessWidget {
  const CourierProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkShift? shift = context.watch<User>().courier!.shift;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          CourierProfileCard(),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MoneyHolder(
                  text: 'Оплата наличными',
                  sum: context.read<User>().courier!.cash),
              MoneyHolder(
                  text: 'Оплата картой',
                  sum: context.read<User>().courier!.terminal),
              MoneyHolder(
                  text: 'Заработная плата',
                  sum: context.read<User>().courier!.salary),
            ],
          ),
          ...shift == null
              ? [
                  SizedBox(height: 40),
                  Button(
                    text: 'Начать смену',
                    buttonType: ButtonType.Panel,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return ChangeNotifierProvider.value(
                          value: Provider.of<User>(context, listen: false),
                          child: StartWorkDialog(),
                        );
                      },
                    ),
                  ),
                  Spacer(flex: 100),
                  Text(
                    'Начните смену, чтобы\nприступить к работе',
                    style: TxtStyle.mainText,
                    textAlign: TextAlign.center,
                  ),
                  Spacer(flex: 213),
                ]
              : [
                  Spacer(flex: 40),
                  Row(
                    children: [
                      Text(
                        'В работе',
                        style: TxtStyle.selectedMainText,
                      ),
                    ],
                  ),
                  Spacer(flex: 16),
                  BorderBox(
                    height: 182,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TimeHolder(
                                text: 'Начало смены',
                                time: shift.begin!,
                                disabled: true,
                                onChange: (time) => {},
                              ),
                              TimeHolder(
                                text: 'Конец смены',
                                time: shift.end!,
                                disabled: true,
                                onChange: (time) => {},
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          MovementSelection(
                            index: shift.movement!,
                            disabled: true,
                            onChange: (int) => {},
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(flex: 72),
                  Button(
                    text: 'Закончить смену',
                    buttonType: ButtonType.Decline,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return ChangeNotifierProvider.value(
                          value: Provider.of<User>(context, listen: false),
                          child: StopWorkDialog(),
                        );
                      },
                    ),
                  ),
                  Spacer(flex: 24),
                ],
        ],
      ),
    );
  }
}
