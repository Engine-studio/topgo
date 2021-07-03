import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:topgo/pages/login.dart';
import 'package:topgo/pages/menu.dart';
import 'package:topgo/styles.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TopGo',
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen.withScreenFunction(
        splashIconSize: double.infinity,
        backgroundColor: Color(0xFF16A7D8),
        splash: Container(
          decoration: BoxDecoration(
            gradient: GrdStyle.splash,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75),
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        screenFunction: () async {
          User user = User();
          return ChangeNotifierProvider<User>(
            create: (context) => user,
            child: user.logined! ? MenuPage() : LoginPage(),
          );
        },
      ),
    );
  }
}
