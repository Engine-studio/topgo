import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';

class BorderBox extends StatelessWidget {
  final Widget child;
  final double width, height;
  final bool selected;
  final double borderWidth;

  const BorderBox({
    Key? key,
    required this.child,
    required this.height,
    this.width = double.infinity,
    this.selected = false,
    this.borderWidth = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width + borderWidth * 2,
      height: height + borderWidth * 2,
      decoration: BoxDecoration(
        gradient:
            selected ? GrdStyle.accept : GrdStyle().lightPanelGradient(context),
        borderRadius: BorderRadius.circular(6),
        boxShadow: borderWidth > 0
            ? [BoxShadow(color: ClrStyle.dropShadow, blurRadius: 3)]
            : [],
      ),
      child: Container(
        margin: EdgeInsets.all(borderWidth),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(6),
        ),
        child: child,
      ),
    );
  }
}
