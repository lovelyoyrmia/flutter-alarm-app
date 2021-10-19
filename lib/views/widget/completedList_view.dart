import 'package:alarm_app/_utils/show_toast.dart';
import 'package:alarm_app/data/color_theme.dart';
import 'package:alarm_app/models/list_info.dart';
import 'package:alarm_app/src/myList_helper.dart';
import 'package:alarm_app/views/card/myList_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'mylist_form.dart';

class CompletedListView extends StatefulWidget {
  const CompletedListView({Key? key}) : super(key: key);

  @override
  _CompletedListViewState createState() => _CompletedListViewState();
}

class _CompletedListViewState extends State<CompletedListView> {
  List<MyListInfo>? _currentListCompleted;

  @override
  Widget build(BuildContext context) {
    return Consumer<MyListHelper>(
      builder: (context, myListHelper, child) =>
          FutureBuilder<List<MyListInfo>>(
        future: myListHelper.getMyList(),
        builder: (context, snapshot) {
          _currentListCompleted = snapshot.data;
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: _currentListCompleted!.map<Widget>(
                (myList) {
                  final createdTime =
                      DateFormat.yMEd().format(myList.createdTime);
                  final gradientColor =
                      GradientMyListTemplate.color[myList.colorIndex].colors;
                  if (myList.isDone == true)
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: MyListCard(
                        myList: myList,
                        createdTime: createdTime,
                        gradientColor: gradientColor,
                        onPressedCompleted: () async {
                          myListHelper.toogleMyListCompleted(myList);
                          ShowToast.showToast(
                            'Your list incomplete',
                            context,
                          );
                        },
                        onPressedEdit: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => MyListForm(
                              myListInfo: myList,
                            ),
                          );
                        },
                        onPressedDelete: () {
                          myListHelper.delete(myList.id);
                          ShowToast.showToast(
                            'Your list has been deleted permanently',
                            context,
                          );
                        },
                      ),
                    );
                  else
                    return SizedBox.shrink();
                },
              ).toList(),
            );
          }
        },
      ),
    );
  }
}
