import 'package:alarm_app/views/page/list_completed_page.dart';
import 'package:alarm_app/views/widget/myList_view.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyListPage extends StatelessWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'TODO LIST'.text.xl4.bold.black.make().shimmer(
                      primaryColor: Theme.of(context).colorScheme.onSurface,
                      secondaryColor: Theme.of(context).colorScheme.onPrimary,
                      duration: Duration(seconds: 2, milliseconds: 5),
                    ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ListCompleted(),
                      ),
                    );
                  },
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: MyListView(),
          ),
        ],
      ),
    );
  }
}
