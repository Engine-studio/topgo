import 'package:flutter/widgets.dart';
import 'package:topgo/api/couriers.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/dialog.dart';
import 'package:provider/provider.dart';

class CourierDeletingDialog extends StatelessWidget {
  final SimpleCourier courier;
  const CourierDeletingDialog({
    Key? key,
    required this.courier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogBox(
      title: 'Внимание!',
      height: 267,
      children: [
        Text(
          'Вы собираетесь удалить аккаунт\nданного курьера.' +
              '\n\nВы точно хотите это сделать?',
          style: TxtStyle.mainText,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24),
        Button(
          text: 'Принять',
          buttonType: ButtonType.Accept,
          onPressed: () async => {
            if (courier.id != null) await deleteCourier(context, courier),
            context.read<User>().deleteCourier(courier),
            Navigator.pop(context),
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
    );
  }
}
