import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasktime_bloc/src/models/task_model.dart';
import 'package:tasktime_bloc/src/resources/database.dart';
import 'package:tasktime_bloc/src/resources/database_provider.dart';
import 'package:tasktime_bloc/utils/ui/components/slide_left_background.dart';
import 'package:tasktime_bloc/utils/ui/components/slide_right_background.dart';
import 'package:tasktime_bloc/utils/ui/components/task_entry.dart';
import 'package:tasktime_bloc/utils/ui/screens/task_list_screen.dart';
import 'package:vibration/vibration.dart';


class TaskList extends StatefulWidget{
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList>{

  void removeTask(TaskItem _item){
    ///function to remove the task from the database
    void dbRemove(_item) async {
      final db = await database;
      await db.delete(
        'tasks',
        where: "id = ?",
        whereArgs: [_item.id],
      );
    }
    setState(() {
      itemsList = List.from(itemsList)
        ..remove(_item);
      dbRemove(_item);
    });
  }

  void editTask(int _index, TaskItem _item) {
    setState(() {
      itemsList = List.from(itemsList)
        ..remove(_item);
    });
    Navigator.of(this.context).pushNamed('/task_entry', arguments: [_item, 'editing done']).then((result) {
      setState(() {
        if (_item.durationTime.inSeconds != 0 && _item.status == true) {
          _item.status = false;
        }
        itemsList = List.from(itemsList)
          ..insert(_index, _item);
        dbUpdate(_item);
      });
    });
  }

  void addRemovedTask(int _index, TaskItem _item){
    setState(() {
      itemsList = List.from(itemsList)
        ..insert(_index, _item);
      dbRestore(_item);
    });
  }


  @override
  Widget build (BuildContext context) {
    return FutureBuilder(
        future: loadDatabase(),
        builder: (context, taskListSnapshot) {
          if (taskListSnapshot.hasData) {
            if (taskListSnapshot.data.isEmpty ?? true) {
              return Center(child: Text(
                  'Hey! Your list is empty,\n add a new task!',
                  textAlign: TextAlign.center, style: Theme
                  .of(context)
                  .textTheme
                  .headline6));
            }
            return ReorderableListView(
                onReorder: (int oldTaskIndex, int newTaskIndex) {
                  if (newTaskIndex > taskListSnapshot.data.length) {
                    newTaskIndex = taskListSnapshot.data.length;
                  }
                  if (newTaskIndex > oldTaskIndex) {
                    newTaskIndex -= 1;
                  }
                  //setState(() {
                  if (newTaskIndex != oldTaskIndex) {
                    //task.id starts from 1,TaskIndex starts from 0
                    var _task = taskListSnapshot.data[oldTaskIndex];
                    var _replacementTask = taskListSnapshot
                        .data[newTaskIndex];
                    //reassigning the task IDs
                    _task.id = newTaskIndex + 1;
                    _replacementTask.id = oldTaskIndex + 1;
                    //reordering the database
                    dbUpdate(_task);
                    dbUpdate(_replacementTask);
                  }
                  //});
                },
                children: List.generate(
                    taskListSnapshot.data.length, (index) {
                  final _task = taskListSnapshot.data[index];
                  return Dismissible(key: ValueKey(_task.id),
                      background: slideRightBackground(),
                      secondaryBackground: slideLeftBackground(),
                      onDismissed: (direction) {
                        Vibration.vibrate(duration: 100, amplitude: 255);
                        if (direction == DismissDirection.startToEnd) {
                          //dismissible forces widget removal from the tree
                          //first I'm removing the widget, after I'm reinserting it
                          taskListSnapshot.data.removeAt(index);
                          editTask(index, _task);
                        }
                        if (direction == DismissDirection.endToStart) {
                          TaskItem _removedTask = _task;
                          taskListSnapshot.data.removeAt(index);
                          removeTask(_task);
                          final snackBar = SnackBar(
                              content: Text('Task was removed'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  HapticFeedback.mediumImpact();
                                  addRemovedTask(index, _removedTask);
                                },
                              )
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: TaskListEntry(task: _task)
                  );
                }
                )
            );
          }
          else if (taskListSnapshot.hasError) {
            return Center(child: Text('Error: ${taskListSnapshot.error}'));
          }
          else {
            return Center(child: Text('Loading database'));
          }
        }
    );
  }}