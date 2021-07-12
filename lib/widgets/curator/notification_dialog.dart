import 'package:flutter/widgets.dart';
import 'package:topgo/api/notifications.dart';
import 'package:topgo/models/notification.dart' as topgo;
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/dialog.dart';
import 'package:topgo/widgets/input.dart';

class NotificationDialog extends StatefulWidget {
  const NotificationDialog({Key? key}) : super(key: key);

  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  late TextEditingController title;
  late TextEditingController message;

  @override
  void initState() {
    super.initState();
    title = TextEditingController();
    message = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    topgo.Notification not;
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
                if (title.text != '' && message.text != '')
                  {
                    not = topgo.Notification.create(
                      title: title.text,
                      message: message.text,
                    ),
                    await createNotification(context, not),
                    Navigator.pop(context),
                  },
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
