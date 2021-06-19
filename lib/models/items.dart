import 'package:flutter/widgets.dart';

class Items {
  static bottomNavBarIcons(String role) {
    return ['history', 'rocket', 'user'];
  }

  static bottomNavBarTabs(String role) {
    return <Widget>[
      Center(child: Text('history')),
      Center(child: Text('rocket')),
      Center(child: Text('user')),
    ];
  }
}
