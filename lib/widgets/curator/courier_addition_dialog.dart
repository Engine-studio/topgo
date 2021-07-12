import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/api/couriers.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/dialog.dart';
import 'package:topgo/widgets/input.dart';
import 'package:provider/provider.dart';

class CourierAdditionDialog extends StatefulWidget {
  const CourierAdditionDialog({Key? key}) : super(key: key);

  @override
  _CourierAdditionDialogState createState() => _CourierAdditionDialogState();
}

class _CourierAdditionDialogState extends State<CourierAdditionDialog> {
  late TextEditingController name;
  late TextEditingController surname;
  late TextEditingController patronymic;
  late MaskedTextController phone;
  late TextEditingController password;
  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    surname = TextEditingController();
    patronymic = TextEditingController();
    phone = MaskedTextController(mask: '+0 (000) 000-00-00');
    password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SimpleCourier courier;
    String number;
    return Center(
      child: SingleChildScrollView(
        child: DialogBox(
          title: 'Добавление курьера',
          height: 451,
          children: [
            Input(text: 'Имя', controller: name),
            SizedBox(height: 8),
            Input(text: 'Фамилия', controller: surname),
            SizedBox(height: 8),
            Input(text: 'Отчество', controller: patronymic),
            SizedBox(height: 8),
            Input(text: 'Телефон', maskedController: phone),
            SizedBox(height: 8),
            Input(text: 'Пароль', controller: password),
            SizedBox(height: 24),
            Button(
              text: 'Добавить',
              buttonType: ButtonType.Accept,
              onPressed: () async => {
                number = phone.text,
                for (String str in ['+', '(', ')', '-', ' '])
                  number = number.replaceAll(str, ''),
                if (name.text != '' &&
                    surname.text != '' &&
                    patronymic.text != '' &&
                    number.length == 11 &&
                    password.text != '')
                  {
                    courier = SimpleCourier.create(
                      name: name.text,
                      surname: surname.text,
                      patronymic: patronymic.text,
                      phoneSource: number,
                      password: password.text,
                    ),
                    await newCourier(context, courier),
                    context.read<User>().addCourier(courier),
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
