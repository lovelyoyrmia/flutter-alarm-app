import 'package:alarm_app/_utils/alarm_time.dart';
import 'package:alarm_app/models/alarm_info.dart';
import 'package:alarm_app/src/alarm_helper.dart';
import 'package:alarm_app/src/alarm_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class ActiveAlarm extends StatefulWidget {
  final String? payload;
  static const String routeName = '/active_alarm';
  const ActiveAlarm(this.payload, {Key? key}) : super(key: key);

  @override
  _ActiveAlarmState createState() => _ActiveAlarmState();
}

class _ActiveAlarmState extends State<ActiveAlarm> {
  AlarmInfo? alarmInfo;
  final _alarmNotification = AlarmNotification();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    int _payload = int.parse(widget.payload!);
    return Scaffold(
      body: SafeArea(
        child: Consumer<AlarmHelper>(
          builder: (context, alarmHelper, child) => FutureBuilder<AlarmInfo>(
            future: alarmHelper.getAlarmById(_payload),
            builder: (context, snapshot) {
              alarmInfo = snapshot.data;
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Alarm',
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(height: 13),
                      Icon(
                        Icons.notifications_active_outlined,
                        color: Theme.of(context).primaryColor,
                        size: 60,
                      ),
                      SizedBox(height: sizeHeight / 15),
                      Container(
                        width: sizeWidth / 1.5,
                        child: Text(
                          alarmInfo!.title,
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      SizedBox(height: sizeHeight / 20),
                      Text(
                        AlarmTime.toTime(alarmInfo!.alarmDateTime),
                        style: TextStyle(fontSize: 50),
                      ),
                      SizedBox(height: sizeHeight / 10),
                      Container(
                        width: sizeWidth,
                        child: Text(
                          'Hey Vio !! it\'s time to \n${(alarmInfo!.title)}',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      SizedBox(height: sizeHeight / 20),
                      IconButton(
                        onPressed: () {
                          _alarmNotification.cancelAlarm(alarmInfo!.id);
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
                        },
                        icon: Icon(Icons.cancel_rounded),
                        iconSize: 50,
                      ),
                      Text(
                        'Cancel',
                      ),
                      SizedBox(height: 20),
                      ConfirmationSlider(
                        text: 'Slide to snooze alarm',
                        foregroundColor: Theme.of(context).primaryColor,
                        onConfirmation: () {
                          _alarmNotification.scheduleAlarm(alarmInfo!);
                          _alarmNotification.snoozeAlarm(alarmInfo!);
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
