import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';

String moneyString(double sum) {
  String str = sum.toStringAsFixed(2);
  int len = str.length;
  String floating = str.substring(len - 3);
  str = str.substring(0, len - 3);
  int amount = (3 - len % 3) % 3;
  for (int i = 0; i < amount; i++) str = '0' + str;
  str = str.replaceAllMapped(RegExp(r".{3}"), (match) => " ${match.group(0)}");
  return '${str.substring(amount + 1)}$floating руб';
}

class MoneyHolder extends StatelessWidget {
  final String text;
  final double sum;
  const MoneyHolder({Key? key, required this.text, required this.sum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
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
