import 'package:alarm_app/_utils/show_dialog_delete.dart';
import 'package:alarm_app/_customs/custom_rect_tween.dart';
import 'package:alarm_app/_customs/hero_dialog_route.dart';
import 'package:alarm_app/models/list_info.dart';
import 'package:alarm_app/views/card/detail_myList_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyListCard extends StatelessWidget {
  final String createdTime;
  final MyListInfo myList;
  final List<Color> gradientColor;
  final Function()? onPressedCompleted;
  final Function()? onPressedEdit;
  final Function() onPressedDelete;
  const MyListCard({
    Key? key,
    this.onPressedCompleted,
    this.onPressedEdit,
    required this.createdTime,
    required this.gradientColor,
    required this.myList,
    required this.onPressedDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onLongPress: () {
          showDialogDelete(context, onPressedDelete);
        },
        onTap: () {
          Navigator.of(context).push(
            HeroDialogRoute(
              builder: (context) => DetailMyList(
                myList: myList,
                gradientColor: gradientColor,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Hero(
            tag: myList.id,
            createRectTween: (begin, end) =>
                CustomRectTween(begin: begin!, end: end!),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Slidable(
                  child: buildCard(context),
                  actionPane: SlidableDrawerActionPane(),
                  key: Key(myList.id.toString()),
                  actions: [
                    IconSlideAction(
                      icon: Icons.edit,
                      color: Theme.of(context).primaryColor,
                      caption: 'Edit',
                      onTap: onPressedEdit,
                    ),
                  ],
                  secondaryActions: [
                    myList.isDone == false
                        ? IconSlideAction(
                            icon: Icons.check_circle_outline,
                            color: Color(0xFF61A3FE),
                            caption: 'Completed',
                            onTap: onPressedCompleted,
                          )
                        : IconSlideAction(
                            icon: Icons.cancel_outlined,
                            color: Theme.of(context).errorColor,
                            caption: 'Incomplete',
                            onTap: onPressedCompleted,
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        color: gradientColor.last.withOpacity(0.4),
      ),
      // TODO: there still remains a bug if it pops up the card
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.label,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: myList.isImportant == true
                          ? MediaQuery.of(context).size.width / 2.4
                          : MediaQuery.of(context).size.width / 1.8,
                      child: Text(
                        myList.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  createdTime,
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 10),
                myList.description.isNotEmpty
                    ? Container(
                        width: myList.isImportant == true
                            ? MediaQuery.of(context).size.width / 2
                            : MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          myList.description,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
          myList.isImportant == true
              ? Container(
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    'assets/images/checkList.png',
                    fit: BoxFit.cover,
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
