import 'package:alarm_app/_utils/show_dialog_delete.dart';
import 'package:alarm_app/components/buttons/toggle_switch_button.dart';
import 'package:alarm_app/models/alarm_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlarmCard extends StatelessWidget {
  final List<Color> gradientColor;
  final String alarmTime;
  final AlarmInfo alarm;
  final Function() onPressedEditAlarm;
  final Function() onPressedDeleteAlarm;
  const AlarmCard({
    Key? key,
    required this.gradientColor,
    required this.alarmTime,
    required this.alarm,
    required this.onPressedEditAlarm,
    required this.onPressedDeleteAlarm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: gradientColor.last.withOpacity(0.4),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.label,
                color: Theme.of(context).colorScheme.onSurface,
                size: 25,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  alarm.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ToggleSwitchButton(alarm: alarm),
              ),
            ],
          ),
          Text(
            'Mon - Fri',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                alarmTime,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: 30,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    onPressed: onPressedEditAlarm,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      size: 30,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    onPressed: () {
                      showDialogDelete(context, onPressedDeleteAlarm);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
