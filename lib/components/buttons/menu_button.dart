import 'package:alarm_app/models/menu_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildMenuButton(MenuInfo currentMenuInfo) {
  return Consumer<MenuInfo>(
    builder: (context, value, child) {
      return TextButton(
        onPressed: () {
          final menuInfo = Provider.of<MenuInfo>(context, listen: false);
          menuInfo.updateMenu(currentMenuInfo);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: currentMenuInfo.menuType == value.menuType
                    ? Theme.of(context).accentColor
                    : Theme.of(context).colorScheme.primaryVariant,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                currentMenuInfo.image!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text(
              currentMenuInfo.title!,
              style: TextStyle(
                fontSize: 14,
                color: currentMenuInfo.menuType == value.menuType
                    ? Theme.of(context).accentColor
                    : Theme.of(context).colorScheme.primaryVariant,
              ),
            ),
          ],
        ),
      );
    },
  );
}
