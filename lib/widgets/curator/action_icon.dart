import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';

class ActionIcon extends StatelessWidget {
  final bool accept;
  final String iconName;
  final Future<void> Function() onTap;
  const ActionIcon({
    Key? key,
    this.accept = true,
    required this.iconName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          gradient: accept ? GrdStyle.accept : GrdStyle.decline,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: iconName == 'call'
              ? Image(
                  image: ResizeImage(
                    AssetImage('assets/icons/$iconName.png'),
                    width: 19,
                    height: 21,
                  ),
                  color: ClrStyle.lightBackground,
                )
              : Image.asset(
                  'assets/icons/$iconName.png',
                  width: 24,
                  color: ClrStyle.lightBackground,
                ),
        ),
      ),
    );
  }
}
