import 'package:alarm_app/views/widget/alarm_view.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'YOUR ALARM'.text.xl4.bold.black.make().pOnly(top: 20).shimmer(
                primaryColor: Theme.of(context).colorScheme.onSurface,
                secondaryColor: Theme.of(context).colorScheme.onPrimary,
                duration: Duration(seconds: 2, milliseconds: 5),
              ),
          SizedBox(height: 20),
          Expanded(
            child: AlarmView(),
          ),
        ],
      ),
    );
  }
}
