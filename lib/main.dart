import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:topgo/functions/phone_string.dart';
import 'package:topgo/models/restaurant.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/pages/login.dart';
import 'package:topgo/pages/menu.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/map/map.dart';
import 'package:topgo/widgets/map/map_card.dart';
import 'package:topgo/widgets/map/map_marker.dart';

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
                User user = User();

                Location location = Location();
                PermissionStatus permissionStatus = PermissionStatus.granted;

                while (permissionStatus != PermissionStatus.granted) {
                  permissionStatus = await location.hasPermission();
                  if (permissionStatus != PermissionStatus.granted) {
                    permissionStatus = await location.requestPermission();
                  }
                }

                return ChangeNotifierProvider<User>(
                  create: (context) => user,
                  //TODO: implement normal thing
                  child: user.logined ? MenuPage() : Scaffold(),
                  // Scaffold(
                  //     body: SafeArea(
                  //       child: Padding(
                  //         padding: const EdgeInsets.only(
                  //             left: 16, right: 16, top: 200),
                  //         child: MapCard(
                  //           markers: [
                  //             MapMarker.restaurant(
                  //               restaurant: Restaurant.create(
                  //                 name: 'name',
                  //                 address: 'address',
                  //                 phone: phoneString('79772702321'),
                  //                 password: '',
                  //                 schedule: {},
                  //                 x: 55.982427,
                  //                 y: 37.134834,
                  //                 open: [8, 0],
                  //                 close: [20, 0],
                  //               ),
                  //             ),
                  //             MapMarker.courier(
                  //               courier: SimpleCourier.create(
                  //                 surname: 'surname',
                  //                 name: 'name',
                  //                 patronymic: 'patronymic',
                  //                 phoneSource: '79772702321',
                  //                 password: '',
                  //                 x: 55.986927,
                  //                 y: 37.138034,
                  //                 action: 'Забирает заказ №11412312312',
                  //                 image:
                  //                     'https://thumbs.dreamstime.com/b/cargo-delivery-service-male-courier-unload-truck-uniform-box-hand-unloads-cardboard-parcels-empty-container-97837453.jpg',
                  //                 movement: 1,
                  //                 rating: 3.6,
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                );
              },
            ),
    );
  }
}
