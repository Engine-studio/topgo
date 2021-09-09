import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/curator/courier_discard_dialog.dart';
import 'package:topgo/widgets/money_holder.dart';
import 'package:topgo/widgets/flag.dart';

class FinanceCard extends StatelessWidget {
  final SimpleCourier courier;

  const FinanceCard({Key? key, required this.courier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SimpleCourier cour = courier;
    return Column(
      children: [
        Flag(
            text: courier.action!, gradient: GrdStyle().panelGradient(context)),
        SizedBox(height: 8),
        BorderBox(
          height: 229,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 74,
                      height: 74,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(courier.photo, fit: BoxFit.fill),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        courier.fullName,
                        style: TxtStyle.selectedMainText,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MoneyHolder(
                      text: 'Оплата наличными',
                      sum: courier.cash!,
                      bordered: false,
                    ),
                    MoneyHolder(
                      text: 'Оплата картой',
                      sum: courier.terminal!,
                      bordered: false,
                    ),
                    MoneyHolder(
                      text: 'Заработная плата',
                      sum: courier.salary!,
                      bordered: false,
                    ),
                  ],
                ),
                Spacer(),
                Button(
                  text: 'Сбросить показатели',
                  buttonType: ButtonType.Accept,
                  filled: false,
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (_) {
                        for (SimpleCourier c
                            in context.read<User>().shownCouriers)
                          if ("[<'${c.id!}'>]" == this.key.toString()) cour = c;
                        return ChangeNotifierProvider.value(
                          value: Provider.of<User>(context, listen: false),
                          child: CourierDiscardDialog(courier: cour),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
