import 'package:flutter/widgets.dart';
import 'package:topgo/functions/money_string.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';

class MoneyHolder extends StatelessWidget {
  final String text;
  final double sum;
  final bool bordered;
  const MoneyHolder({
    Key? key,
    required this.text,
    required this.sum,
    this.bordered = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(text, style: TxtStyle.selectedSmallText),
          ),
          BorderBox(
            height: 35,
            borderWidth: bordered ? 1.5 : 0,
            child: Center(
              child: Text(
                moneyString(sum),
                style: TxtStyle.smallText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
