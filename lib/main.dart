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
import 'package:background_fetch/background_fetch.dart';
import 'dart:io' show Platform;

import 'models/user.dart';

const pollingDelay = 20000; // 1 minute polling delay
const extraPollingDelay = 300000; // 5 minute extra polling delay
const locationPollingDelay = 20000; // 20 sec polling delay for location fetch
const pollingTaskId = "1111";
const extraPollingTaskId = "2222";
const locationPollingId = "3333";

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('logo');

final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
  requestAlertPermission: true,
  requestBadgePermission: true,
  requestSoundPermission: true,
  onDidReceiveLocalNotification: (
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {},
);

final InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsIOS,
);

void showNotification(not.Notification not) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    color: const Color.fromARGB(0, 106, 165, 215),
    ticker: 'ticker',
  );

  IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    not.message.hashCode,
    not.title,
    not.message,
    platformChannelSpecifics,
  );
}

void backgroundFetchFunction(HeadlessTask task) {
  final taskId = task.taskId;
  final timeout = task.timeout;

  BackgroundFetch.finish(taskId);
  if (timeout || taskId == 'flutter_background_fetch') {
    return;
  }

  BackgroundFetch.scheduleTask(TaskConfig(
    taskId: taskId,
    delay: pollingDelay,
    periodic: false,
    forceAlarmManager: true,
    stopOnTerminate: false,
    enableHeadless: true,
    requiresNetworkConnectivity: true,
    requiresCharging: true,
  ));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String? payload) async {},
  );

  runApp(MyApp());

  if (Platform.isAndroid) {
    print('Android detected in main');
    await BackgroundFetch.registerHeadlessTask(backgroundFetchFunction);
    print('task registered');
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Location location = Location();
  bool? granted;

  Future<void> checkPermissions() async {
    if (await location.hasPermission() == PermissionStatus.granted)
      setState(() {
        granted = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    checkPermissions();
    return (granted == true)
        ? ChangeNotifierProvider<User>(
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
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? phone = prefs.getString('phone');
                    String? password = prefs.getString('password');
                    User user = await logInFirst(phone, password);
                    context.read<User>().copy(user);

                    return user.logined ? MenuPage() : LoginPage();
                  },
                ),
              );
            },
          )
        : MaterialApp(
            title: 'TopGo',
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 78,
                  horizontal: 30,
                ),
                decoration: BoxDecoration(gradient: GrdStyle.splash),
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
                        while (granted != true) {
                          await location.requestPermission();
                          await checkPermissions();
                        }
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
