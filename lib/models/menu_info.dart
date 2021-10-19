import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum MenuType { clock, alarm, list }

class MenuInfo extends ChangeNotifier {
  MenuType menuType;
  String? title;
  String? image;

  MenuInfo(this.menuType, {this.title, this.image});
  updateMenu(MenuInfo menuInfo) {
    this.menuType = menuInfo.menuType;
    this.title = menuInfo.title;
    this.image = menuInfo.image;

    notifyListeners();
  }
}

List<MenuInfo> menuItems = [
  MenuInfo(
    MenuType.clock,
    title: 'Clock',
    image: 'assets/images/clock.png',
  ),
  MenuInfo(
    MenuType.alarm,
    title: 'Alarm',
    image: 'assets/images/alarm.png',
  ),
  MenuInfo(
    MenuType.list,
    title: 'My List',
    image: 'assets/images/mylist.png',
  ),
];
