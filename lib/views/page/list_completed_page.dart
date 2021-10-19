import 'package:alarm_app/views/widget/completedList_view.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ListCompleted extends StatelessWidget {
  const ListCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30,
                  ),
                  SizedBox(width: 10),
                  'COMPLETED'.text.xl4.bold.black.make().shimmer(
                        primaryColor: Theme.of(context).colorScheme.onSurface,
                        secondaryColor: Theme.of(context).colorScheme.onPrimary,
                        duration: Duration(seconds: 2, milliseconds: 5),
                      ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(child: CompletedListView()),
            ],
          ),
        ),
      ),
    );
  }
}
