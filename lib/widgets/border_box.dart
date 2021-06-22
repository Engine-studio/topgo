import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';

class BorderBox extends StatelessWidget {
  final Widget child;
  final double width, height;
  final bool selected;

  const BorderBox({
    Key? key,
    required this.child,
    required this.height,
    this.width = double.infinity,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient:
            selected ? GrdStyle.accept : GrdStyle().lightPanelGradient(context),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [BoxShadow(color: ClrStyle.dropShadow, blurRadius: 3)],
      ),
      child: Container(
        margin: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(6),
        ),
        child: child,
      ),
    );
  }
}
