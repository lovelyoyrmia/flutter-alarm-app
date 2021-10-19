import 'package:alarm_app/_utils/alarm_time.dart';
import 'package:alarm_app/_utils/show_toast.dart';
import 'package:alarm_app/components/buttons/text_input_button.dart';
import 'package:alarm_app/models/alarm_info.dart';
import 'package:alarm_app/src/alarm_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlarmForm extends StatelessWidget {
  final AlarmInfo? alarmInfo;
  final int? colorIndex;
  const AlarmForm({
    Key? key,
    this.alarmInfo,
    this.colorIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _alarmHelper = context.read<AlarmHelper>();
    final _formKey = GlobalKey<FormState>();
    final now = DateTime.now();
    final alarmIsNull = alarmInfo == null;
    String? _title = alarmInfo?.title;
    DateTime? alarmDateTime = alarmInfo?.alarmDateTime;
    TimeOfDay? _selectedTime;

    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              children: [
                TextButton(
                  onPressed: () async {
                    _selectedTime = await showTimePicker(
                      context: context,
                      initialTime: alarmIsNull
                          ? TimeOfDay.now()
                          : TimeOfDay.fromDateTime(alarmDateTime!),
                    );
                    if (_selectedTime == null) return null;
                    final selectedDateTime = DateTime(
                      now.year,
                      now.month,
                      now.day,
                      _selectedTime!.hour,
                      _selectedTime!.minute,
                    );
                    setModalState(() {
                      alarmDateTime = selectedDateTime;
                    });
                  },
                  child: Text(
                    !alarmIsNull || _selectedTime != null
                        ? AlarmTime.toTime(alarmDateTime!)
                        : AlarmTime.toTime(alarmDateTime ?? now),
                    style: TextStyle(
                      fontSize: 32,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                TextInputButton(
                  title: 'Title',
                  readOnly: false,
                  initialValue: _title,
                  icon: Icons.title_rounded,
                  onChanged: (value) => _title = value,
                  validator: (_title) {
                    if (_title!.isEmpty) {
                      return 'The title can\'t be empty';
                    }
                    return null;
                  },
                ),
                // TextInputButton(
                //   onPressed: () {},
                //   title: 'Repeat',
                //   icon: Icons.arrow_forward_ios,
                //   readOnly: true,
                // ),
                // TextInputButton(
                //   onPressed: () {},
                //   title: 'Sound',
                //   icon: Icons.arrow_forward_ios,
                //   readOnly: true,
                // ),
                SizedBox(height: 10),
                FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  label: Text(
                    alarmIsNull ? 'Save' : 'Edit',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    final isValid = _formKey.currentState!.validate();
                    if (isValid) {
                      if (!alarmIsNull) {
                        alarmInfo!.title = _title!;
                        alarmInfo!.alarmDateTime = alarmDateTime!;
                        _alarmHelper.update(context, alarmInfo!);
                      } else {
                        final alarmInfo = AlarmInfo(
                          id: AlarmTime.createUniqueId(),
                          title: _title!,
                          alarmDateTime: alarmDateTime ??= now,
                          colorIndex: colorIndex!,
                        );
                        _alarmHelper.insert(alarmInfo);
                      }
                      ShowToast.showToast(
                        alarmIsNull ? 'Alarm Saved' : 'Alarm Edited',
                        context,
                      );
                      Navigator.pop(context);
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
