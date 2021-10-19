import 'package:alarm_app/_utils/show_snack_bar.dart';
import 'package:alarm_app/models/alarm_info.dart';
import 'package:alarm_app/src/alarm_helper.dart';
import 'package:alarm_app/src/alarm_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToggleSwitchButton extends StatefulWidget {
  final AlarmInfo alarm;

  const ToggleSwitchButton({
    Key? key,
    required this.alarm,
  }) : super(key: key);

  @override
  _ToggleSwitchButtonState createState() => _ToggleSwitchButtonState();
}

class _ToggleSwitchButtonState extends State<ToggleSwitchButton> {
  @override
  Widget build(BuildContext context) {
    final alarmHelper = Provider.of<AlarmHelper>(context, listen: false);
    bool _value = widget.alarm.isPending;
    return Consumer<AlarmNotification>(
      builder: (context, alarmNotification, child) {
        return CupertinoSwitch(
          value: _value,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (bool value) {
            setState(() {
              if (_value = value) {
                alarmNotification.scheduleAlarm(widget.alarm);
                print(value);
                ShowSnackBar.showSnackBarBottom(
                  context,
                  'Alarm Scheduled from now',
                  Icon(
                    Icons.notifications_active,
                    color: Theme.of(context).primaryColor,
                  ),
                );
              } else {
                alarmNotification.cancelAlarm(widget.alarm.id);
                print(value);
                ShowSnackBar.showSnackBarBottom(
                  context,
                  'Alarm Canceled',
                  Icon(
                    Icons.notifications_off,
                    color: Theme.of(context).errorColor,
                  ),
                );
              }
            });
            widget.alarm.isPending = _value;
            alarmHelper.update(context, widget.alarm);
          },
        );
      },
    );
  }
}
