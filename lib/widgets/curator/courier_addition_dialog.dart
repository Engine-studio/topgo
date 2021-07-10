import 'package:flutter/widgets.dart';
import 'package:topgo/api/couriers.dart';
import 'package:topgo/models/simple_courier.dart';
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
              onPressed: () async => {
                if (name.text != '' &&
                    surname.text != '' &&
                    patronymic.text != '' &&
                    phone.text != '' &&
                    password.text != '')
                  {
                    await newCourier(
                      context,
                      SimpleCourier.create(
                        name: name.text,
                        surname: surname.text,
                        patronymic: patronymic.text,
                        phoneSource: phone.text,
                        password: password.text,
                      ),
                    ),
                    Navigator.pop(context),
                  }
              },
            ),
            SizedBox(height: 8),
            Button(
              text: 'Отказать',
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
