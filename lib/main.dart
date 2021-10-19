import 'package:alarm_app/data/theme/theme_data.dart';
import 'package:alarm_app/models/menu_info.dart';
import 'package:alarm_app/src/alarm_helper.dart';
import 'package:alarm_app/src/alarm_notifications.dart';
import 'package:alarm_app/src/myList_helper.dart';
import 'package:alarm_app/src/theme_provider.dart';
import 'package:alarm_app/views/page/active_alarm.dart';
import 'package:alarm_app/views/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

bool didAlarmLaunchApp = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AlarmHelper().initializeDb().then((value) => print('db my list init'));
  MyListHelper().initializedDb().then((value) => print('db alarm init'));
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp == true) {
    selectedPayload = notificationAppLaunchDetails!.payload;
    didAlarmLaunchApp = true;
  }
  await initNotification(initSchedule: true)
      .then((value) => print('alarm notifications init'));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<MenuInfo>(
          create: (_) => MenuInfo(MenuType.clock),
        ),
        ChangeNotifierProvider<MyListHelper>(
          create: (_) => MyListHelper(),
        ),
        ChangeNotifierProvider<AlarmHelper>(
          create: (_) => AlarmHelper(),
        ),
        ChangeNotifierProvider<AlarmNotification>(
          create: (_) => AlarmNotification(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          ActiveAlarm.routeName: (context) => ActiveAlarm(selectedPayload)
        },
        title: 'Reminder',
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        themeMode:
            themeProvider.isLightTheme ? ThemeMode.light : ThemeMode.dark,
        home: didAlarmLaunchApp ? ActiveAlarm(selectedPayload) : HomePage(),
      ),
    );
  }
}
