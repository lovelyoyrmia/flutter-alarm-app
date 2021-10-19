import 'package:flutter/material.dart';

class ShowBottomSheet extends StatelessWidget {
  final Widget child;
  const ShowBottomSheet({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 150,
            height: 6,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

Future showBottomSheetAlarm(BuildContext context, Widget child) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (_) => SingleChildScrollView(
      child: ShowBottomSheet(
        child: child,
      ),
    ),
  );
}
