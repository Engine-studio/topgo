import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/items.dart';
import 'package:topgo/widgets/appbar.dart';
import 'package:topgo/widgets/bottom_navbar.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentIndex = 0;
  List<String> icons = Items.bottomNavBarIcons('courier');
  List<Widget> tabs = Items.bottomNavBarTabs('courier');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        icons[currentIndex],
        withSearch: icons[currentIndex] == 'history',
        onPressed: () {
          setState(() {
            this.currentIndex = icons.length - 1;
          });
        },
      ),
      body: SafeArea(
        child: tabs[currentIndex],
      ),
      bottomNavigationBar: BottomNavBar(
        icons: icons.sublist(0, icons.length - 1),
        onPressed: (index) {
          setState(() {
            this.currentIndex = index;
          });
        },
      ),
    );
  }
}
