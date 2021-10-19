import 'package:alarm_app/_utils/show_snack_bar.dart';
import 'package:alarm_app/_utils/show_toast.dart';
import 'package:alarm_app/models/alarm_info.dart';
import 'package:alarm_app/src/alarm_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

final String tableAlarm = 'alarmV';
final String columnAlarmId = 'id';
final String columnAlarmTitle = 'title';
final String columnAlarmDateTime = 'alarmDateTime';
final String columnAlarmColor = 'color';
final String columnAlarmIsPending = 'isPending';

class AlarmHelper extends ChangeNotifier {
  final _alarmNotification = AlarmNotification();
  static Database? _database;
  static AlarmHelper? _alarmHelper;

  AlarmHelper._createInstance();
  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper._createInstance();
    }
    return _alarmHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDb();
    }
    return _database!;
  }

  Future<Database> initializeDb() async {
    var dir = await getDatabasesPath();
    var path = dir + "alarmV.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        create table $tableAlarm(
         $columnAlarmId integer primary key autoincrement,
         $columnAlarmTitle text not null,
         $columnAlarmDateTime text not null,
         $columnAlarmColor integer,
         $columnAlarmIsPending)
       ''');
      },
    );
    return database;
  }

  Future<void> insert(AlarmInfo alarm) async {
    var db = await this.database;
    await db.insert(tableAlarm, alarm.toJson());
    notifyListeners();
  }

  Future<List<AlarmInfo>> getAlarms() async {
    var db = await this.database;
    var result = await db.query(
      tableAlarm,
      orderBy: '$columnAlarmDateTime asc',
    );
    return result.map((map) => AlarmInfo.fromJson(map)).toList();
  }

  Future<AlarmInfo> getAlarmById(int id) async {
    var db = await this.database;
    List<Map<String, dynamic>> result = await db.query(
      tableAlarm,
      where: '$columnAlarmId = ?',
      whereArgs: [id],
    );
    return AlarmInfo.fromJson(result.first);
  }

  Future<void> update(BuildContext context, AlarmInfo alarm) async {
    var db = await this.database;
    await db.update(
      tableAlarm,
      alarm.toJson(),
      where: '$columnAlarmId = ?',
      whereArgs: [alarm.id],
    );
    if (alarm.isPending == true) {
      _alarmNotification.scheduleAlarm(alarm);
      ShowToast.removeToast();
      ShowSnackBar.showSnackBarBottom(
        context,
        'Alarm Scheduled from now',
        Icon(
          Icons.notifications_active,
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    notifyListeners();
  }

  Future<void> delete(int id) async {
    _alarmNotification.cancelAlarm(id);
    var db = await this.database;
    await db.delete(
      tableAlarm,
      where: '$columnAlarmId = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<Database> close() async {
    var db = await this.database;
    await db.close();
    return db;
  }

  void deleteDB() async {
    var dir = await getDatabasesPath();
    var path = dir + "alarmVio.db";
    await deleteDatabase(path);
  }

  // bool toggleSwitchButton(AlarmInfo alarm) {
  //   alarm.isPending = !alarm.isPending;
  //   // _alarmHelper!.update(alarm);
  //   return alarm.isPending;
  // }
}
