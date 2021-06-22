import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/courier/money_holder.dart';
import 'package:topgo/widgets/courier/profile_card.dart';
import 'package:topgo/widgets/courier/start_work_dialog.dart';

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
          SizedBox(height: 100),
          Text(
            'Начните смену, чтобы\nприступить к работе',
            style: TxtStyle.mainText,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
