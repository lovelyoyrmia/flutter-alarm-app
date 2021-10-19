import 'package:alarm_app/models/list_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

final String tableMyList = 'mylistVio';
final String columnMyListId = 'id';
final String columnMyListIsImportant = 'isImportant';
final String columnMyListTitle = 'title';
final String columnMyListDescription = 'description';
final String columnMyListDateTime = 'createdTime';
final String columnMyListColorIndex = 'colorIndex';
final String columnMyListIsDone = 'isDone';

class MyListHelper extends ChangeNotifier {
  static Database? _database;
  static MyListHelper? _myListHelper;

  MyListHelper._createInstance();
  factory MyListHelper() {
    if (_myListHelper == null) {
      _myListHelper = MyListHelper._createInstance();
    }
    return _myListHelper!;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializedDb();
    }
    return _database!;
  }

  Future<Database> initializedDb() async {
    var dir = await getDatabasesPath();
    var path = dir + "mylistVio.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        create table $tableMyList(
          $columnMyListId integer primary key autoincrement,
          $columnMyListTitle text not null,
          $columnMyListDateTime text not null,
          $columnMyListIsImportant integer,
          $columnMyListDescription text not null,
          $columnMyListColorIndex integer,
          $columnMyListIsDone integer)
        ''');
      },
    );
    return database;
  }

  Future<void> insert(MyListInfo myList) async {
    var db = await this.database;
    await db.insert(tableMyList, myList.toJson());

    notifyListeners();
  }

  Future<MyListInfo> getMyListById(int id) async {
    var db = await this.database;
    List<Map<String, dynamic>> result = await db.query(
      tableMyList,
      where: '$columnMyListId = ?',
      whereArgs: [id],
    );
    return MyListInfo.fromJson(result.first);
  }

  Future<List<MyListInfo>> getMyList() async {
    var db = await this.database;
    var result = await db.query(
      tableMyList,
      orderBy: '$columnMyListDateTime asc',
    );
    return result.map((map) => MyListInfo.fromJson(map)).toList();
  }

  Future<void> update(MyListInfo myList) async {
    var db = await this.database;
    await db.update(
      tableMyList,
      myList.toJson(),
      where: '$columnMyListId = ?',
      whereArgs: [myList.id],
    );
    notifyListeners();
  }

  Future<void> delete(int id) async {
    var db = await this.database;
    await db.delete(
      tableMyList,
      where: '$columnMyListId = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<Database> close() async {
    var db = await this.database;
    await db.close();
    return db;
  }

  Future<bool> toogleMyListCompleted(MyListInfo myListInfo) async {
    myListInfo.isDone = !myListInfo.isDone;
    _myListHelper!.update(myListInfo);

    return myListInfo.isDone;
  }
}
