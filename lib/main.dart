import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topgo/api/general.dart';
import 'package:topgo/pages/login.dart';
import 'package:topgo/pages/menu.dart';
import 'package:topgo/styles.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PermissionStatus? _permissionGranted;
  Location _location = Location();

  Future<void> _checkPermissions() async {
    final PermissionStatus permissionGrantedResult =
        await _location.hasPermission();
    setState(() {
      _permissionGranted = permissionGrantedResult;
    });
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
          await _location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkPermissions();
    return MaterialApp(
      title: 'TopGo',
      debugShowCheckedModeBanner: false,
      home: _permissionGranted != PermissionStatus.granted
          ? Container(
              decoration: BoxDecoration(
                gradient: GrdStyle.splash,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 75),
                child: Image.asset('assets/images/logo.png'),
              ),
            )
          : AnimatedSplashScreen.withScreenFunction(
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
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? phone = prefs.getString('phone');
                String? password = prefs.getString('password');
                User user = await firstLogIn(phone, password);

                Location location = Location();
                PermissionStatus permissionStatus = PermissionStatus.granted;

                while (permissionStatus != PermissionStatus.granted) {
                  permissionStatus = await location.hasPermission();
                  if (permissionStatus != PermissionStatus.granted) {
                    permissionStatus = await location.requestPermission();
                  }
                }

                // TODO: delete this
                user.copy(User.shadow());

                return ChangeNotifierProvider<User>(
                  create: (context) => user,
                  child: user.logined ? MenuPage() : LoginPage(),
                );
              },
            ),
    );
  }
}
