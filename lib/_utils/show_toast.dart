import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  static void showToast(String text, BuildContext context) =>
      Fluttertoast.showToast(
        msg: text,
        fontSize: 14,
        gravity: ToastGravity.CENTER,
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        textColor: Theme.of(context).colorScheme.onPrimary,
        toastLength: Toast.LENGTH_SHORT,
      );
  static void removeToast() => Fluttertoast.cancel();
}
