import 'package:alarm_app/src/alarm_helper.dart';

class AlarmInfo {
  int id;
  String title;
  DateTime alarmDateTime;
  int colorIndex;
  bool isPending;

  AlarmInfo({
    this.id = 0,
    this.isPending = false,
    required this.title,
    required this.alarmDateTime,
    required this.colorIndex,
  });

  factory AlarmInfo.fromJson(Map<String, dynamic> map) => AlarmInfo(
        id: map[columnAlarmId],
        title: map[columnAlarmTitle],
        alarmDateTime: DateTime.parse(map[columnAlarmDateTime]),
        colorIndex: map[columnAlarmColor],
        isPending: map[columnAlarmIsPending] == 1,
      );

  Map<String, dynamic> toJson() => {
        columnAlarmId: id,
        columnAlarmTitle: title,
        columnAlarmDateTime: alarmDateTime.toIso8601String(),
        columnAlarmColor: colorIndex,
        columnAlarmIsPending: isPending ? 1 : 0,
      };
}
