import 'package:sqflite/sqflite.dart';
import 'package:tasktime_bloc/src/resources/database.dart';
import 'package:tasktime_bloc/src/resources/database_provider.dart';


class TaskItem {
  //data fields definition
  int id;
  String taskName;
  String taskDescription;
  Duration durationTime;
  bool status;
  DateTime creationDate;
  DateTime deadlineDate;
  bool expanded;
  String taskImagePath;

  //class constructor
  TaskItem(
      this.id,
      this.taskName,
      this.taskDescription,
      this.durationTime,
      this.status,
      this.creationDate,
      this.deadlineDate,
      this.expanded,
      this.taskImagePath);
  //class method
  Map<String, dynamic> toMap() {
    //mapping the TaskItem data fields to database fields
    int _statusInteger = (status)? 1 : 0;
    int _durationSeconds = durationTime.inSeconds;
    String creationDateString = creationDate.toIso8601String();
    String deadlineDateString = deadlineDate.toIso8601String();
    int _expandedInteger = (expanded)? 1 : 0;

    return {
      'name': taskName,
      'body': taskDescription,
      'seconds': _durationSeconds,
      'status': _statusInteger,
      'creationDate': creationDateString,
      'deadlineDate': deadlineDateString,
      'expanded': _expandedInteger,
      'imagePath': taskImagePath,
    };
  }


}


