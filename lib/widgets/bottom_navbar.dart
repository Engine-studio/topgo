import 'package:flutter/material.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  final void Function(int) onPressed;
  final List<String> icons;
  const BottomNavBar({
    Key? key,
    required this.onPressed,
    required this.icons,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() =>
      _BottomNavBarState(this.onPressed, this.icons);
}

class _BottomNavBarState extends State<BottomNavBar> {
  final void Function(int) onPressed;
  final List<String> icons;
  int? _currentIndex;

  _BottomNavBarState(this.onPressed, this.icons);

  @override
  Widget build(BuildContext context) {
    int orders = context.read<User>().role == Role.Courier
        ? context.watch<User>().courier!.ordersRequest.length
        : -1;

    if (_currentIndex == null)
      _currentIndex = context.read<User>().role == Role.Courier ? 2 : 0;

    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        height: 83,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(0, -0.5),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex!,
            type: BottomNavigationBarType.fixed,
            backgroundColor: ClrStyle.lightBackground,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            items: icons
                .map(
                  (icon) => BottomNavigationBarItem(
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ShaderMask(
                          shaderCallback: _currentIndex! == icons.indexOf(icon)
                              ? (bounds) => GrdStyle.select.createShader(bounds)
                              : (bounds) => GrdStyle()
                                  .panelGradient(context)
                                  .createShader(bounds),
                          child: Image.asset(
                            'assets/icons/$icon.png',
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                        ...icon == 'rocket' && orders > 0
                            ? [
                                Positioned(
                                  left: 24,
                                  bottom: 15,
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: _currentIndex! ==
                                              icons.indexOf(icon)
                                          ? GrdStyle.select
                                          : GrdStyle().panelGradient(context),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$orders',
                                        style:
                                            TxtStyle.selectedSmallText.copyWith(
                                          color: ClrStyle.lightBackground,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                            : [],
                      ],
                    ),
                    label: icon,
                  ),
                )
                .toList(),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                onPressed(index);
              });
            },
          ),
        ),
      ),
    );
  }
}
