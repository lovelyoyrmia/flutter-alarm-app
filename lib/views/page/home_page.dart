import 'package:alarm_app/components/buttons/menu_button.dart';
import 'package:alarm_app/models/menu_info.dart';
import 'package:alarm_app/src/alarm_notifications.dart';
import 'package:alarm_app/views/page/alarm_page.dart';
import 'package:alarm_app/views/page/clock_page.dart';
import 'package:alarm_app/views/page/myList_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _configureSelectNotification() {
    onNotifications.stream.listen(
      (String? payload) async {
        await Navigator.pushNamed(context, '/active_alarm');
      },
    );
  }

  @override
  void initState() {
    _configureSelectNotification();
    super.initState();
  }

  @override
  void dispose() {
    onNotifications.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer<MenuInfo>(
                builder: (context, value, child) {
                  if (value.menuType == MenuType.clock) {
                    return ClockPage();
                  } else if (value.menuType == MenuType.alarm) {
                    return AlarmPage();
                  } else {
                    return MyListPage();
                  }
                },
              ),
            ),
            Divider(
              height: 1,
              color: Theme.of(context).colorScheme.primaryVariant,
            ),
            Container(
              padding: EdgeInsets.all(5),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: menuItems
                    .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
