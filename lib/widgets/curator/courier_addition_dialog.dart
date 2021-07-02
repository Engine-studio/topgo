import 'package:flutter/widgets.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/dialog.dart';
import 'package:topgo/widgets/input.dart';

class CourierAdditionDialog extends StatelessWidget {
  const CourierAdditionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController surname = TextEditingController();
    TextEditingController patronymic = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController password = TextEditingController();
    return Center(
      child: SingleChildScrollView(
        child: DialogBox(
          title: 'Добавление TODOTODOTODO',
          height: 451,
          children: [
            Input(text: 'Имя', controller: name),
            SizedBox(height: 8),
            Input(text: 'Фамилия', controller: surname),
            SizedBox(height: 8),
            Input(text: 'Отчество', controller: patronymic),
            SizedBox(height: 8),
            Input(text: 'Телефон', controller: phone),
            SizedBox(height: 8),
            Input(text: 'Пароль', controller: password),
            SizedBox(height: 24),
            Button(
              text: 'Добавить',
              buttonType: ButtonType.Accept,
              onPressed: () => {
                //TODO: implement for curators and couriers
                //TODO: implement addition function
                Navigator.pop(context),
              },
            ),
            SizedBox(height: 8),
            Button(
              text: 'Отказать',
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
