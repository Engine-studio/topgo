import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topgo/api/general.dart';
import 'package:topgo/models/notification.dart' as not;
import 'package:topgo/pages/login.dart';
import 'package:topgo/pages/menu.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/button.dart';

import 'models/user.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void showNotification(not.Notification not) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('', '', '');

  IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    not.message.hashCode,
    not.title,
    not.message,
    platformChannelSpecifics,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('notification');
  IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification:
              (int id, String? title, String? body, String? payload) async {});
  InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<User>(
      create: (_) => User(),
      builder: (context, _) {
        return MaterialApp(
          title: 'TopGo',
          debugShowCheckedModeBanner: false,
          home: AnimatedSplashScreen.withScreenFunction(
            duration: 1000,
            animationDuration: Duration(milliseconds: 900),
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
              User user = await logInFirst(phone, password);
              context.read<User>().copy(user);

              Location location = Location();

              return (await location.hasPermission() !=
                      PermissionStatus.granted)
                  ? RequestPage()
                  : user.logined
                      ? MenuPage()
                      : LoginPage();
            },
          ),
        );
      },
    );
  }
}

class RequestPage extends StatelessWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 78,
          horizontal: 30,
        ),
        decoration: BoxDecoration(gradient: GrdStyle.splash),
        child: SafeArea(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 50,
              ),
              Spacer(flex: 75),
              Text(
                'Использование геопозиции',
                style: TxtStyle.mainHeader.copyWith(
                  color: ClrStyle.lightBackground,
                ),
              ),
              Spacer(flex: 50),
              Text(
                'Чтобы воспользоваться приложением TopGo разрешите' +
                    ' использовать данные о вашем местоположении',
                textAlign: TextAlign.center,
                style: TxtStyle.mainText.copyWith(
                  color: ClrStyle.lightBackground,
                ),
              ),
              Spacer(flex: 20),
              Text(
                'Мы собираем данные о вашем местоположении для расчета сто' +
                    'имости доставки и трекинга процесса доставки кураторами' +
                    ' в режиме реального времени',
                textAlign: TextAlign.center,
                style: TxtStyle.mainText.copyWith(
                  color: ClrStyle.lightBackground,
                ),
              ),
              Spacer(flex: 87),
              Button(
                text: 'Принять',
                buttonType: ButtonType.Accept,
                onPressed: () async {
                  Location location = Location();

                  while (await location.hasPermission() !=
                      PermissionStatus.granted)
                    await location.requestPermission();

                  if (await location.hasPermission() ==
                      PermissionStatus.granted)
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),
              SizedBox(height: 20),
              Button(
                text: 'Отказаться',
                buttonType: ButtonType.Decline,
                onPressed: () async {},
              ),
              Spacer(flex: 202),
            ],
          ),
        ),
      ),
    );
  }
}
