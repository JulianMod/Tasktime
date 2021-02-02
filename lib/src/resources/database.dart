import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//database getter
Future<Database> get database async {
  Database _database = await openDatabase(
    join(await getDatabasesPath(), 'task_list.db'),
    onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, name TEXT, body TEXT, seconds INTEGER, status INTEGER, creationDate TEXT, deadlineDate TEXT, expanded INTEGER, imagePath TEXT)"
      );
    },
    version: 1,
  );
  return _database;
}