import 'package:flutter/material.dart';

Future<void> showDialogDelete(
  BuildContext context,
  Function() onPressedDelete,
) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.fromLTRB(30, 24, 30, 20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Do you want to delete this?',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: onPressedDelete,
                child: Text(
                  'Delete',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
