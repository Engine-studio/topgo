import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/api/restaurants.dart' as api;
import 'package:topgo/models/restaurant.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/courier/time_holder.dart';
import 'package:topgo/widgets/dialog.dart';
import 'package:topgo/widgets/input.dart';

class RestaurantAdditionDialog extends StatefulWidget {
  const RestaurantAdditionDialog({Key? key}) : super(key: key);

  @override
  _RestaurantAdditionDialogState createState() =>
      _RestaurantAdditionDialogState();
}

class _RestaurantAdditionDialogState extends State<RestaurantAdditionDialog> {
  late TextEditingController name, address, password, email, lat, lng;
  late MaskedTextController phone;
  late RegExp regExp;
  List<int> open = [8, 0], close = [23, 0];

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    address = TextEditingController();
    lat = MaskedTextController(mask: '00. 000000');
    lng = MaskedTextController(mask: '00. 000000');
    phone = MaskedTextController(mask: '+0 (000) 000-00-00');
    password = TextEditingController();
    email = TextEditingController();
    regExp = RegExp(r"^[^\s@]+@([^\s@.,]+\.)+[^\s@.,]{2,}$",
        caseSensitive: false, multiLine: false);
  }

  @override
  Widget build(BuildContext context) {
    Restaurant restaurant;
    String number;
    double? lat_val, lng_val;
    return Center(
      child: SingleChildScrollView(
        child: DialogBox(
          title: 'Добавление ресторана',
          height: 598,
          children: [
            Input(text: 'Название', controller: name),
            SizedBox(height: 8),
            Input(text: 'Адрес', controller: address),
            SizedBox(height: 8),
            SizedBox(
              height: 44,
              child: Row(
                children: [
                  Flexible(child: Input(text: 'lat (с. ш.)', controller: lat)),
                  SizedBox(width: 8),
                  Flexible(child: Input(text: 'lng (в. д.)', controller: lng)),
                ],
              ),
            ),
            SizedBox(height: 8),
            Input(text: 'Телефон', maskedController: phone),
            SizedBox(height: 8),
            Input(text: 'Почта', controller: email),
            SizedBox(height: 8),
            Input(text: 'Пароль', controller: password),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TimeHolder(
                  text: 'Открытие',
                  time: this.open,
                  disabled: false,
                  onChange: (time) => {this.open = time},
                ),
                TimeHolder(
                  text: 'Закрытие',
                  time: this.close,
                  disabled: false,
                  onChange: (time) => {this.close = time},
                ),
              ],
            ),
            Spacer(),
            Button(
              text: 'Добавить',
              buttonType: ButtonType.Accept,
              onPressed: () async => {
                number = phone.text,
                lat_val = double.tryParse(lat.text.replaceAll(' ', '')),
                lng_val = double.tryParse(lng.text.replaceAll(' ', '')),
                for (String str in ['+', '(', ')', '-', ' '])
                  number = number.replaceAll(str, ''),
                if (name.text != '' &&
                    address.text != '' &&
                    lat_val != null &&
                    lng_val != null &&
                    number.length == 11 &&
                    password.text != '' &&
                    email.text != '' &&
                    regExp.hasMatch(email.text) &&
                    (open[0] < close[0] ||
                        ((open[0] == close[0]) && open[1] < close[1])))
                  {
                    restaurant = Restaurant.create(
                      name: name.text,
                      address: address.text,
                      x: lat_val,
                      y: lng_val,
                      phone: number,
                      email: email.text,
                      password: password.text,
                      open: [open],
                      close: [close],
                    ),
                    if (await api.newRestaurant(context, restaurant))
                      await api.getRestaurants(context),
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
