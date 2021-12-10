import 'package:flutter/widgets.dart';
import 'package:topgo/functions/money_string.dart';
import 'package:topgo/styles.dart';

class OrderInfoHolder extends StatelessWidget {
  final int time;
  final String payment;
  final double sum;
  const OrderInfoHolder({
    Key? key,
    required this.time,
    required this.payment,
    required this.sum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String pay = payment == 'Cash'
        ? 'Наличные'
        : payment == 'Card'
            ? 'Терминал'
            : 'Оплачен';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) =>
                    GrdStyle().panelGradient(context).createShader(bounds),
                child: Image(
                  image: ResizeImage(
                    AssetImage('assets/icons/time.png'),
                    width: 20,
                    height: 20,
                  ),
                  color: Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(width: 8),
              Text('$time мин', style: TxtStyle.smallText),
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) =>
                    GrdStyle().panelGradient(context).createShader(bounds),
                child: Image(
                  image: ResizeImage(
                    AssetImage('assets/icons/payment.png'),
                    width: 20,
                    height: 15,
                  ),
                  color: Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(width: 8),
              Text(pay, style: TxtStyle.smallText),
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) =>
                    GrdStyle().panelGradient(context).createShader(bounds),
                child: Image(
                  image: ResizeImage(
                    AssetImage('assets/icons/receipt.png'),
                    width: 20,
                    height: 20,
                  ),
                  color: Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(width: 8),
              Text(
                moneyString(sum, fix: 1),
                style: TxtStyle.smallText
                    .copyWith(overflow: TextOverflow.ellipsis),
              )
            ],
          ),
        ),
      ],
    );
  }
}
