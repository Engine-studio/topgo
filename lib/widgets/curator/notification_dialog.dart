import 'package:flutter/widgets.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/dialog.dart';
import 'package:topgo/widgets/input.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController text = TextEditingController();
    return Center(
      child: SingleChildScrollView(
        child: DialogBox(
          title: 'Создать уведомление',
          height: 371,
          children: [
            Input(text: 'Заголовок', controller: title),
            SizedBox(height: 24),
            Input(text: 'Введите текст', controller: text, multilined: true),
            SizedBox(height: 24),
            Button(
              text: 'Отправить',
              buttonType: ButtonType.Accept,
              onPressed: () => {
                //TODO: implement send function
                Navigator.pop(context),
              },
            ),
            SizedBox(height: 8),
            Button(
              text: 'Назад',
              buttonType: ButtonType.Decline,
              filled: false,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}