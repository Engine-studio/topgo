import 'package:flutter/widgets.dart';
import 'package:topgo/api/couriers.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/dialog.dart';

class CourierBlockingDialog extends StatelessWidget {
  final SimpleCourier courier;
  const CourierBlockingDialog({
    Key? key,
    required this.courier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogBox(
      title: 'Внимание!',
      height: 301,
      children: [
        Text(
          'Вы собираетесь заблокировать\nданного курьера. Он не сможет' +
              '\nполучать и выполнять заказы, пока\nне будет разблокирован.' +
              '\n\nВы точно хотите это сделать?',
          style: TxtStyle.mainText,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24),
        Button(
          text: 'Принять',
          buttonType: ButtonType.Accept,
          onPressed: () async => {
            await blockCourier(context, courier),
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
