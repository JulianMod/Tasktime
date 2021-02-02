import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasktime_bloc/src/models/task_model.dart';
import 'package:tasktime_bloc/src/resources/database.dart';
import 'package:tasktime_bloc/src/resources/database_provider.dart';
import 'package:tasktime_bloc/utils/ui/components/task_list.dart';

List itemsList = <TaskItem>[];

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  void addTask() async {
    Future<int> retrieveLastTaskId() async{
      final Database db = await database;
      int _newTaskId;
      //I don't like it but I don't know how to do it in more smooth way
      List<Map<String, dynamic>> _lastRowIdDbMap = await db.rawQuery('SELECT last_insert_rowid()');
      List _lastRowIdDbList = _lastRowIdDbMap[0].values.toList();
      if (_lastRowIdDbList[0] == 1){
        _newTaskId = 1;
      } else {
        _newTaskId = _lastRowIdDbList[0] + 1;
      }
      return _newTaskId;
    }
    var _newTaskId = await retrieveLastTaskId();
    var _newTask = TaskItem(
        _newTaskId,
        'New task name',
        'New task description',
        Duration(hours: 0, minutes: 0, seconds: 0),
        false,
        DateTime.now(),
        DateTime.now(),
        false,
        '');
    //passing null as an ID for the database to automatically increment the ID
    await Navigator.of(this.context).pushNamed(
        '/task_entry', arguments: [_newTask, 'add task']).then((result) {
      if (result != null) {
        setState(() {
          _newTask = result;
          itemsList = List.from(itemsList)
            ..add(_newTask);
          dbInsert(_newTask);
        });
      }
    });
  }

  // This widget is the root of your application.
  ///retrieve the database at the start of application - load the task list from the file
  Widget build(BuildContext context) {
    final title = 'List of tasks';

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[IconButton(
            icon: Icon(
                Icons.settings
            ),
            onPressed: () {
              HapticFeedback.mediumImpact();
              Navigator.of(context).pushNamed('/settings_screen');
            },
          )
          ],
        ),
        body: TaskList(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            HapticFeedback.mediumImpact();
            addTask();
          },
          label: Text('create task'),
          icon: Icon(Icons.add),
        )
    );
  }
}