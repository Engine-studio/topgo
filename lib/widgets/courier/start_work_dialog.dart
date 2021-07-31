import 'package:flutter/material.dart';
import 'package:topgo/api/work.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/courier/movement_selection.dart';
import 'package:topgo/widgets/courier/terminal_selection.dart';
import 'package:topgo/widgets/courier/time_holder.dart';
import 'package:topgo/widgets/dialog.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class StartWorkDialog extends StatelessWidget {
  List<int> begin = [9, 0], end = [18, 0];
  int movement = 0;
  bool terminal = false;

  StartWorkDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkShift shift;
    return DialogBox(
      title: 'Начало смены',
      height: 476,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimeHolder(
              text: 'Начало смены',
              time: this.begin,
              disabled: false,
              onChange: (time) => {this.begin = time},
            ),
            TimeHolder(
              text: 'Конец смены',
              time: this.end,
              disabled: false,
              onChange: (time) => {this.end = time},
            ),
          ],
        ),
        SizedBox(height: 32),
        TerminalSelection(onChange: (has) => {this.terminal = has}),
        SizedBox(height: 32),
        MovementSelection(
          onChange: (movement) => {this.movement = movement},
          disabled: false,
        ),
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
          onPressed: () async => {
            if ((2 < end[0] - begin[0] && end[0] - begin[0] < 10) ||
                (end[0] - begin[0] == 2 && end[1] >= begin[1]) ||
                (end[0] - begin[0] == 10 && end[1] <= begin[1]))
              {
                shift = WorkShift.create(
                  movement: movement,
                  begin: begin,
                  end: end,
                  hasTerminal: terminal,
                ),
                if (await startWorkShift(context, shift))
                  context.read<User>().startWorkShift(shift: shift),
                Navigator.pop(context),
              },
          },
        )
      ],
    );
  }
}
