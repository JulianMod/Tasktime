import 'package:sqflite/sqflite.dart';
import 'package:tasktime_bloc/src/models/task_model.dart';
import 'database.dart';

Future loadDatabase() async{
  final Database db = await database;
  final List<Map<String, dynamic>> maps = await db.query('tasks');
  var itemsList = List<TaskItem>.generate(maps.length, (i){
    return TaskItem(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['body'],
        //possible problems with mapping database item to task item
        Duration(seconds: maps[i]['seconds']),
        (maps[i]['status'] == 1? true : false),
        DateTime.parse(maps[i]['creationDate']),
        DateTime.parse(maps[i]['deadlineDate']),
        (maps[i]['expanded'] == 1? true : false),
        maps[i]['imagePath']
    );
  });
  return itemsList;
}

void dbUpdate(_item) async {
  final db = await database;
  await db.update(
    'tasks',
    _item.toMap(),
    where: "id = ?",
    whereArgs: [_item.id],
  );
}

void dbInsert(_item) async {
  ///inserting new task into the task database
  final Database db = await database;
  await db.insert(
    'tasks',
    _item.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

void dbRestore(TaskItem _item) async {
  final Database db = await database;
  await db.rawInsert(
      "INSERT INTO tasks (id, name, body, seconds, status, creationDate, deadlineDate, expanded, imagePath)"
          "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
      [_item.id,
        _item.taskName,
        _item.taskDescription,
        _item.durationTime.inSeconds,
        _item.status? 1 : 0,
        _item.creationDate.toIso8601String(),
        _item.deadlineDate.toIso8601String(),
        _item.expanded? 1 : 0,
        _item.taskImagePath]
  );
}

///function to remove the task from the database
void dbRemove(_item) async {
  final db = await database;
  await db.delete(
    'tasks',
    where: "id = ?",
    whereArgs: [_item.id],
  );
}