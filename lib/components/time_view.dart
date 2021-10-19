import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeInHourAndMinute extends StatefulWidget {
  const TimeInHourAndMinute({Key? key}) : super(key: key);

  @override
  _TimeInHourAndMinuteState createState() => _TimeInHourAndMinuteState();
}

class _TimeInHourAndMinuteState extends State<TimeInHourAndMinute> {
  var _timeFormat = DateFormat('hh:mm aa').format(DateTime.now());
  Timer? timer;
  @override
  void initState() {
    this.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      var previousMinute = DateTime.now().add(Duration(seconds: -1)).minute;
      var currentMinute = DateTime.now().minute;
      if (previousMinute != currentMinute)
        setState(() {
          _timeFormat = DateFormat('hh:mm aa').format(DateTime.now());
        });
    });

    super.initState();
  }

  @override
  void dispose() {
    this.timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeFormat,
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
