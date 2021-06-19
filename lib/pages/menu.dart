import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/models/items.dart';
import 'package:topgo/widgets/bottom_navbar.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Widget currentPage = Center(child: Text('history'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: currentPage,
      ),
      bottomNavigationBar: BottomNavBar(
        icons: Items.bottomNavBarIcons('courier'),
        onPressed: (index) {
          setState(() {
            this.currentPage = Items.bottomNavBarTabs('courier')[index];
          });
        },
      ),
    );
  }
}
