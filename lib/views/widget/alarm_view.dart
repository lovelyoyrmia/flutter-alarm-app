import 'package:alarm_app/_utils/show_bottom_sheet_alarm.dart';
import 'package:alarm_app/_utils/show_snack_bar.dart';
import 'package:alarm_app/components/buttons/bottom_add_button.dart';
import 'package:alarm_app/data/color_theme.dart';
import 'package:alarm_app/models/alarm_info.dart';
import 'package:alarm_app/src/alarm_helper.dart';
import 'package:alarm_app/views/widget/alarm_form.dart';
import 'package:alarm_app/views/card/alarm_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({
    Key? key,
  }) : super(key: key);

  @override
  _AlarmViewState createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  List<AlarmInfo>? _currentAlarm;
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmHelper>(
      builder: (context, alarmHelper, child) => FutureBuilder<List<AlarmInfo>>(
        future: alarmHelper.getAlarms(),
        builder: (context, snapshot) {
          _currentAlarm = snapshot.data;
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else
            return ListView(
              physics: BouncingScrollPhysics(),
              children: _currentAlarm!.map<Widget>(
                (alarm) {
                  final alarmTime =
                      DateFormat('hh:mm aa').format(alarm.alarmDateTime);
                  final gradientColor =
                      GradientAlarmTemplate.color[alarm.colorIndex].colors;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: AlarmCard(
                      alarmTime: alarmTime,
                      gradientColor: gradientColor,
                      alarm: alarm,
                      onPressedEditAlarm: () {
                        showBottomSheetAlarm(
                          context,
                          AlarmForm(alarmInfo: alarm),
                        );
                      },
                      onPressedDeleteAlarm: () async {
                        alarmHelper.delete(alarm.id);
                        ShowSnackBar.showSnackBarBottom(
                          context,
                          'Alarm has been deleted',
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                alarmHelper.insert(alarm);
                              });
                              ShowSnackBar.removeSnackBar(context);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.undo,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Undo',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ).followedBy([
                if (_currentAlarm!.length < 6)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: BottomAddButton(
                      image: 'assets/images/alarm.png',
                      title: 'Add Alarm',
                      onPressed: () {
                        showBottomSheetAlarm(
                          context,
                          AlarmForm(
                            colorIndex: _currentAlarm!.length,
                          ),
                        );
                      },
                    ),
                  )
                else
                  Center(
                    child: Text(
                      'Only 6 alarm allowed!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                      ),
                    ),
                  ),
              ]).toList(),
            );
        },
      ),
    );
  }
}
