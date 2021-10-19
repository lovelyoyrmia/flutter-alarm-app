import 'package:alarm_app/_utils/show_snack_bar.dart';
import 'package:alarm_app/components/buttons/bottom_add_button.dart';
import 'package:alarm_app/data/color_theme.dart';
import 'package:alarm_app/models/list_info.dart';
import 'package:alarm_app/src/myList_helper.dart';
import 'package:alarm_app/views/card/myList_card.dart';
import 'package:alarm_app/views/widget/mylist_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyListView extends StatefulWidget {
  const MyListView({
    Key? key,
  }) : super(key: key);

  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List<MyListInfo>? _currentList;
  @override
  Widget build(BuildContext context) {
    return Consumer<MyListHelper>(
      builder: (context, myListHelper, child) =>
          FutureBuilder<List<MyListInfo>>(
        future: myListHelper.getMyList(),
        builder: (context, snapshot) {
          _currentList = snapshot.data;
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              physics: BouncingScrollPhysics(),
              children: _currentList!.map<Widget>(
                (myList) {
                  final createdTime =
                      DateFormat.yMEd().format(myList.createdTime);
                  final gradientColor =
                      GradientMyListTemplate.color[myList.colorIndex].colors;
                  if (myList.isDone == false)
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: MyListCard(
                        createdTime: createdTime,
                        gradientColor: gradientColor,
                        myList: myList,
                        onPressedCompleted: () async {
                          myListHelper.toogleMyListCompleted(myList);
                          ShowSnackBar.showSnackBarBottom(
                            context,
                            'Todo Completed',
                            Icon(
                              Icons.check_outlined,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          );
                        },
                        onPressedDelete: () async {
                          myListHelper.delete(myList.id);
                          ShowSnackBar.showSnackBarBottom(
                            context,
                            'List has been deleted',
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  myListHelper.insert(myList);
                                });
                                ShowSnackBar.removeSnackBar(context);
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.undo,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Undo',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          Navigator.pop(context);
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
                      ),
                    );
                  else
                    return SizedBox.shrink();
                },
              ).followedBy([
                if (_currentList!.length < 6)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: BottomAddButton(
                      image: 'assets/images/mylist.png',
                      title: 'Add Your List',
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => MyListForm(
                            colorIndex: _currentList!.length,
                          ),
                        );
                      },
                    ),
                  )
                else
                  Center(
                    child: Text(
                      'Only 6 list allowed!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                      ),
                    ),
                  ),
              ]).toList(),
            );
        },
      ),
    );
  }
}
