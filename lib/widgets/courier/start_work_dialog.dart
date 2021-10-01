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
class StartWorkDialog extends StatefulWidget {
  StartWorkDialog({Key? key}) : super(key: key);

  @override
  _StartWorkDialogState createState() => _StartWorkDialogState();
}

class _StartWorkDialogState extends State<StartWorkDialog> {
  List<int> dur = [8, 0];

  int movement = 0;

  bool terminal = false;

  @override
  Widget build(BuildContext context) {
    WorkShift shift;
    DateTime now;
    return DialogBox(
      title: 'Начало смены',
      height: 476,
      children: [
        TimeHolder(
          text: 'Продолжительность смены',
          time: this.dur,
          disabled: false,
          width: 250,
          forShift: true,
          onChange: (time) => {
            setState(() {
              this.dur = time;
            })
          },
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
            if (!(dur[0] == 10 && dur[1] > 0))
              {
                now = DateTime.now(),
                shift = WorkShift.create(
                  movement: movement,
                  begin: [now.hour, now.minute],
                  end: [
                    (now.hour + dur[0] + (now.minute + dur[1]) ~/ 60) % 24,
                    (now.minute + dur[1]) % 60
                  ],
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
