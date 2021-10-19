import 'package:alarm_app/components/clock_view.dart';
import 'package:alarm_app/components/time_view.dart';
import 'package:alarm_app/src/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ClockPage extends StatelessWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('======Digital Clock Updated');
    var _timeOfDay = DateTime.now();

    var _dateFormat = DateFormat('EEE, d MMM').format(_timeOfDay);
    var _timezone = _timeOfDay.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!_timezone.startsWith('-')) {
      offsetSign = '+';
      print(_timezone);
    }
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            'TIME IS MORE IMPORTANT \nTHAN EVERYTHING'
                .text
                .xl3
                .bold
                .align(TextAlign.center)
                .black
                .make()
                .aspectRatio(5)
                .pSymmetric(v: 13, h: 15)
                .shimmer(
                  primaryColor: Theme.of(context).colorScheme.onSurface,
                  secondaryColor: Theme.of(context).colorScheme.onPrimary,
                  duration: Duration(seconds: 2, milliseconds: 5),
                ),
            SizedBox(height: 5),
            Text(
              'So Take Your Time \nand be Productive then',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Column(
              children: [
                TimeInHourAndMinute(),
                SizedBox(height: 5),
                Text(
                  _dateFormat,
                  style: TextStyle(fontSize: 20),
                ),
                ClockView(
                  size: MediaQuery.of(context).size.height / 3.2,
                ),
              ],
            ),
            SizedBox(height: 10),
            Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  // left: 0,
                  right: 0,
                  child: Consumer<ThemeProvider>(
                    builder: (_, themeProvider, child) => IconButton(
                      onPressed: () {
                        themeProvider.changeTheme();
                      },
                      color: Theme.of(context).primaryColor,
                      icon: Icon(
                        themeProvider.isLightTheme
                            ? Icons.wb_sunny_outlined
                            : Icons.nightlight_outlined,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Jakarta, Indonesia',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(' UTC' + offsetSign + _timezone),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
