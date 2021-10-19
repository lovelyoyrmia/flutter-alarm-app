import 'package:alarm_app/_customs/custom_rect_tween.dart';
import 'package:alarm_app/models/list_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailMyList extends StatelessWidget {
  final MyListInfo myList;
  final List<Color> gradientColor;
  const DetailMyList({
    Key? key,
    required this.myList,
    required this.gradientColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final createdTime = DateFormat.yMEd().format(myList.createdTime);
    return Center(
      child: Hero(
        tag: myList.id,
        createRectTween: (begin, end) =>
            CustomRectTween(begin: begin!, end: end!),
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
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
                gradient: LinearGradient(
                  colors: gradientColor,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                color: gradientColor.last.withOpacity(0.8),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.label,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            myList.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.clip,
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
                        ? Text(
                            myList.description,
                            overflow: TextOverflow.clip,
                            style: TextStyle(fontSize: 16),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
