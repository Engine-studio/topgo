import 'package:flutter/widgets.dart';

class Items {
  static List<String> bottomNavBarIcons(String role) {
    return [
      'history',
      'rocket',
      'user',
      'documents',
    ];
  }

  static List<Widget> bottomNavBarTabs(String role) {
    return <Widget>[
      Text('history'),
      Text('rocket'),
      Text('user'),
      Text('documents'),
    ];
  }
}
