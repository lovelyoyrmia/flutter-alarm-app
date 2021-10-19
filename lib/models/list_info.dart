import 'package:alarm_app/src/myList_helper.dart';

class MyListInfo {
  int id;
  bool isImportant;
  bool isDone;
  String title;
  String description;
  DateTime createdTime;
  int colorIndex;

  MyListInfo({
    required this.id,
    required this.isImportant,
    required this.title,
    required this.description,
    required this.createdTime,
    required this.colorIndex,
    this.isDone = false,
  });

  factory MyListInfo.fromJson(Map<String, dynamic> map) => MyListInfo(
        id: map[columnMyListId],
        isImportant: map[columnMyListIsImportant] == 1,
        title: map[columnMyListTitle],
        description: map[columnMyListDescription],
        createdTime: DateTime.parse(map[columnMyListDateTime]),
        colorIndex: map[columnMyListColorIndex],
        isDone: map[columnMyListIsDone] == 1,
      );

  Map<String, dynamic> toJson() => {
        columnMyListTitle: title,
        columnMyListDescription: description,
        columnMyListIsImportant: isImportant ? 1 : 0,
        columnMyListDateTime: createdTime.toIso8601String(),
        columnMyListColorIndex: colorIndex,
        columnMyListIsDone: isDone ? 1 : 0,
      };
}
