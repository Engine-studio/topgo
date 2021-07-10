import 'package:flutter/widgets.dart';
import 'package:topgo/api/notifications.dart';
import 'package:topgo/models/notification.dart' as topgo;
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/dialog.dart';
import 'package:topgo/widgets/input.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController message = TextEditingController();
    return Center(
      child: SingleChildScrollView(
        child: DialogBox(
          title: 'Создать уведомление',
          height: 371,
          children: [
            Input(text: 'Заголовок', controller: title),
            SizedBox(height: 24),
            Input(text: 'Введите текст', controller: message, multilined: true),
            SizedBox(height: 24),
            Button(
              text: 'Отправить',
              buttonType: ButtonType.Accept,
              onPressed: () async => {
                await createNotification(
                  context,
                  topgo.Notification.create(
                    title: title.text,
                    message: message.text,
                  ),
                ),
                Navigator.pop(context),
              },
            ),
            SizedBox(height: 8),
            Button(
              text: 'Назад',
              buttonType: ButtonType.Decline,
              filled: false,
              onPressed: () async => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
