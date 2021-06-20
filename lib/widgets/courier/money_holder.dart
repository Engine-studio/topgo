import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';

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
          Container(
            width: double.infinity,
            height: 35,
            decoration: BoxDecoration(
              gradient: GrdStyle.lightPanel,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [BoxShadow(color: ClrStyle.dropShadow, blurRadius: 3)],
            ),
            child: Container(
              margin: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  moneyString(sum),
                  style: TxtStyle.smallText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
