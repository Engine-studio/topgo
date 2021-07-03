import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';

class Flag extends StatelessWidget {
  final String text;
  final LinearGradient? gradient;

  Flag({
    Key? key,
    required this.text,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LinearGradient? grad = this.gradient != null
        ? this.gradient
        : text.contains('Забирает')
            ? GrdStyle.accept
            : text.contains('Доставляет')
                ? GrdStyle.button
                : text.contains('Заблокирован')
                    ? LinearGradient(
                        colors: [
                          ClrStyle.darkBackground,
                          ClrStyle.darkBackground
                        ],
                      )
                    : GrdStyle.decline;
    return Container(
      width: double.infinity,
      height: 23,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: grad,
      ),
      child: Center(
        child: Text(
          text,
          style: TxtStyle.selectedSmallText.copyWith(
            color: grad ==
                    LinearGradient(colors: [
                      ClrStyle.darkBackground,
                      ClrStyle.darkBackground
                    ])
                ? ClrStyle.text
                : ClrStyle.lightBackground,
          ),
        ),
      ),
    );
  }
}
