import 'package:flutter/widgets.dart';
import 'package:topgo/api/restaurants.dart';
import 'package:topgo/models/restaurant.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/dialog.dart';

class RestaurantDeletingDialog extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantDeletingDialog({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogBox(
      title: 'Внимание!',
      height: 267,
      children: [
        Text(
          'Вы собираетесь удалить аккаунт\nданного ресторана.' +
              '\n\nВы точно хотите это сделать?',
          style: TxtStyle.mainText,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24),
        Button(
          text: 'Принять',
          buttonType: ButtonType.Accept,
          onPressed: () async => {
            await deleteRestaurant(context, restaurant),
            Navigator.pop(context),
          },
        ),
        SizedBox(height: 8),
        Button(
          text: 'Отказаться',
          buttonType: ButtonType.Decline,
          filled: false,
          onPressed: () async => Navigator.pop(context),
        ),
      ],
    );
  }
}
