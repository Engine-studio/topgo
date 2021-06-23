import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/courier/money_holder.dart';
import 'package:topgo/widgets/courier/movement_selection.dart';
import 'package:topgo/widgets/courier/profile_card.dart';
import 'package:topgo/widgets/courier/start_work_dialog.dart';
import 'package:topgo/widgets/courier/stop_work_dialog.dart';
import 'package:topgo/widgets/courier/time_holder.dart';

class CourierProfileTab extends StatelessWidget {
  const CourierProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          ProfileCard(
            surname: 'Константинов',
            name: 'Константин',
            patronymic: 'Константинович',
            phone: '+7 (906) 300-37-37',
            rating: 4.5,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MoneyHolder(text: 'Оплата наличными', sum: 10000),
              MoneyHolder(text: 'Оплата\nпо терминалу', sum: 100000),
              MoneyHolder(text: 'Заработная плата', sum: 1000000),
            ],
          ),
          ...!context.watch<User>().working
              ? [
                  SizedBox(height: 40),
                  Button(
                    text: 'Начать смену',
                    buttonType: ButtonType.Panel,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) {
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
                  SizedBox(height: 16),
                  BorderBox(
                    height: 218,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 24,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TimeHolder(
                                text: 'Начало смены',
                                time: [10, 10],
                                disabled: true,
                                onChange: () => {},
                              ),
                              TimeHolder(
                                text: 'Конец смены',
                                time: [9, 41],
                                disabled: true,
                                onChange: () => {},
                              ),
                            ],
                          ),
                          SizedBox(height: 32),
                          MovementSelection(
                            index: 1,
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
                      builder: (_) {
                        return ChangeNotifierProvider.value(
                          value: Provider.of<User>(context, listen: false),
                          child: StopWorkDialog(),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                ],
        ],
      ),
    );
  }
}
