import 'package:flutter/material.dart';
import 'package:tasktime_bloc/src/models/task_model.dart';
import 'package:tasktime_bloc/utils/helpers/time_helper.dart';

class TaskDurationStatusDisplay extends StatelessWidget {
 final TaskItem task;

  TaskDurationStatusDisplay({Key key,@required this.task}): super(key: key);
  @override
  Widget build(BuildContext context) {
    //show the timer value. if the timer is done display checkbox
    if (task.durationTime.inSeconds != 0 || task.status != true) {
      return RichText(
          text: TextSpan(
              text: printTimerTime(task.durationTime),
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6
          )
      );
    }
    else {
      return Icon(
        Icons.check_box,
        color: Theme
            .of(context)
            .primaryColor,
        size: 24,
      );
    }
  }
}