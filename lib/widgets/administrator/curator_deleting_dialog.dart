import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/dialog.dart';

class CuratorDeletingDialog extends StatelessWidget {
  const CuratorDeletingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogBox(
      title: 'Внимание!',
      height: 267,
      children: [
        Text(
          'Вы собираетесь удалить аккаунт\nданного куратора.' +
              '\n\nВы точно хотите это сделать?',
          style: TxtStyle.mainText,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24),
        Button(
          text: 'Принять',
          buttonType: ButtonType.Accept,
          onPressed: () => {
            //TODO: implement deleting function
            Navigator.pop(context),
          },
        ),
        SizedBox(height: 8),
        Button(
          text: 'Отказаться',
          buttonType: ButtonType.Decline,
          filled: false,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
