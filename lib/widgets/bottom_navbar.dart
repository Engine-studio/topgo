import 'package:flutter/material.dart';
import 'package:topgo/styles.dart';

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
  int _currentIndex = 0;

  _BottomNavBarState(this.onPressed, this.icons);

  @override
  Widget build(BuildContext context) {
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
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: ClrStyle.lightBackground,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            items: icons
                .map((icon) => BottomNavigationBarItem(
                      icon: ShaderMask(
                        shaderCallback: _currentIndex == icons.indexOf(icon)
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
                      label: icon,
                    ))
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
