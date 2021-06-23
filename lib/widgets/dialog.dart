import 'package:flutter/material.dart';
import 'package:topgo/styles.dart';

class DialogBox extends StatelessWidget {
  final String title;
  final double height;
  final List<Widget> children;
  final EdgeInsets padding;

  const DialogBox({
    Key? key,
    required this.title,
    required this.height,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 34),
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Container(
        height: height,
        width: double.infinity,
        padding: this.padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Text(title, style: TxtStyle.mainHeader),
            SizedBox(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }
}
