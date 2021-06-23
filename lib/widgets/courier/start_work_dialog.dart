import 'package:flutter/material.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/courier/movement_selection.dart';
import 'package:topgo/widgets/courier/terminal_selection.dart';
import 'package:topgo/widgets/courier/time_holder.dart';
import 'package:topgo/widgets/dialog.dart';
import 'package:provider/provider.dart';

class StartWorkDialog extends StatelessWidget {
  const StartWorkDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogBox(
      title: 'Начало смены',
      height: 476,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimeHolder(
              text: 'Начало смены',
              time: [9, 0],
              disabled: false,
              onChange: () => {},
            ),
            TimeHolder(
              text: 'Конец смены',
              time: [18, 0],
              disabled: false,
              onChange: () => {},
            ),
          ],
        ),
        SizedBox(height: 32),
        TerminalSelection(onChange: (boola) => {}),
        SizedBox(height: 32),
        MovementSelection(onChange: (inta) => {}, disabled: false),
        SizedBox(height: 24),
        Text(
          'Смена не должна длиться\nменее 2 и более 10 часов',
          style: TxtStyle.mainText,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24),
        Button(
          text: 'Начать',
          buttonType: ButtonType.Accept,
          onPressed: () => {
            context.read<User>().work(),
            Navigator.pop(context),
          },
        )
      ],
    );
  }
}
