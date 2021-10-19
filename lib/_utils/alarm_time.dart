import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmTime {
  static String toTime(DateTime dateTime) {
    final time = DateFormat('hh:mm aa').format(dateTime);
    return '$time';
  }

  static tz.TZDateTime scheduleDaily(DateTime dateTime) {
    final now = tz.TZDateTime.now(tz.local);
    final alarmTime = tz.TZDateTime.from(dateTime, tz.local);
    return alarmTime.isBefore(now)
        ? alarmTime.add(const Duration(days: 1))
        : alarmTime;
  }

  static tz.TZDateTime scheduleWeekly(DateTime dateTime,
      {required List<int> days}) {
    tz.TZDateTime scheduleDate = scheduleDaily(dateTime);

    while (!days.contains(scheduleDate.weekday)) {
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }
    return scheduleDate;
  }

  static int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }
}
