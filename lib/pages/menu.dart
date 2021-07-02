import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/items.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/appbar.dart';
import 'package:topgo/widgets/bottom_navbar.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> icons = Items().bottomNavBarIcons(context);
    List<Widget> tabs = Items().bottomNavBarTabs(context);
    List<AppBarItem> appBarItems = Items().appBarItems(context);
    return Scaffold(
      appBar: Appbar(
        appBarItem: appBarItems[currentIndex],
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
          context.read<User>().updateView('');
          setState(() {
            this.currentIndex = index;
          });
        },
      ),
    );
  }
}
