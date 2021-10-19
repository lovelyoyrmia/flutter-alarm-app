import 'package:flutter/material.dart';

class ShowSnackBar {
  static void showSnackBarBottom(
      BuildContext context, String text, Widget child) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 120, horizontal: 30),
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text, style: TextStyle(fontSize: 13)),
                child,
              ],
            ),
          ),
        ),
      );
  }

  static void removeSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}
