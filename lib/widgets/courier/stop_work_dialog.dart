import 'package:flutter/material.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/dialog.dart';
import 'package:provider/provider.dart';

class StopWorkDialog extends StatelessWidget {
  const StopWorkDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogBox(
      title: 'Внимание!',
      height: 233,
      children: [
        Text(
          'Вы собираетесь закончить смену раньше положенного времени',
          style: TxtStyle.mainText,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24),
        Button(
          text: 'Продолжить смену',
          buttonType: ButtonType.Accept,
          onPressed: () => Navigator.pop(context),
        ),
        SizedBox(height: 8),
        Button(
          text: 'Закончить смену',
          buttonType: ButtonType.Decline,
          filled: false,
          onPressed: () => {
            context.read<User>().courier.stopWork(),
            Navigator.pop(context),
          },
        ),
      ],
    );
  }
}
