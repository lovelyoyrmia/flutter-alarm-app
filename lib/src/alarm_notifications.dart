import 'dart:typed_data';

import 'package:alarm_app/_utils/alarm_time.dart';
import 'package:alarm_app/models/alarm_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

String? selectedPayload;

late List<PendingNotificationRequest> pendingNotificationRequests;

final BehaviorSubject<String?> onNotifications = BehaviorSubject<String?>();

Future<void> initNotification({bool initSchedule = false}) async {
  final initializationSettingsAndroid = AndroidInitializationSettings('alarm');
  final initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (payload) async {
    debugPrint('notification payload: $payload');
    selectedPayload = payload;
    onNotifications.add(payload);
  });
  if (initSchedule) {
    tz.initializeTimeZones();
    final locationName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(locationName));
  }
}

// bool isPending(int id) {
//   // Returns true if id is found in pending list
//   return pendingNotificationRequests
//       .where((pending) => pending.id == id)
//       .isNotEmpty;
// }

class AlarmNotification extends ChangeNotifier {
  static const int insistentFlag = 4;
  final androidPlatformDetails = AndroidNotificationDetails(
    'channel id',
    'channel name',
    'channel body',
    importance: Importance.max,
    priority: Priority.max,
    icon: 'alarm',
    largeIcon: DrawableResourceAndroidBitmap('alarm'),
    sound:
        RawResourceAndroidNotificationSound('bintang_2.mp3'.split('.').first),
    playSound: true,
    additionalFlags: Int32List.fromList(<int>[insistentFlag]),
    ticker: 'ticker',
  );
  final iosNotificationDetails = IOSNotificationDetails(
    sound: 'bintang_2.mp3',
    presentAlert: true,
    presentBadge: true,
    presentSound: false,
  );
  Future<void> checkPendingNotificationRequests() async {
    pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  Future<void> scheduleAlarm(AlarmInfo alarmInfo) async {
    final notificationDetails = NotificationDetails(
      android: androidPlatformDetails,
      iOS: iosNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      alarmInfo.id,
      alarmInfo.title,
      'Hey Vio !! it\'s time to ${alarmInfo.title}',
      // AlarmTime.scheduleWeekly(alarmInfo.alarmDateTime, days: [
      //   DateTime.monday,
      //   DateTime.tuesday,
      //   DateTime.wednesday,
      //   DateTime.thursday,
      //   DateTime.friday
      // ]),
      AlarmTime.scheduleDaily(alarmInfo.alarmDateTime),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: '${(alarmInfo.id)}',
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );

    notifyListeners();
  }

  Future<void> snoozeAlarm(AlarmInfo alarmInfo) async {
    final notificationDetails = NotificationDetails(
      android: androidPlatformDetails,
      iOS: iosNotificationDetails,
    );
    tz.TZDateTime _now = tz.TZDateTime.now(tz.local);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      alarmInfo.id,
      alarmInfo.title,
      'Click to cancel alarm',
      _now.add(const Duration(seconds: 10)),
      notificationDetails,
      androidAllowWhileIdle: true,
      payload: '${(alarmInfo.id)}',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    notifyListeners();
  }

  Future<void> cancelAlarm(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    notifyListeners();
  }

  Future<void> cancelAllAlarm() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    checkPendingNotificationRequests();
  }
}
