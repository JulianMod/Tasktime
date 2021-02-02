import 'package:flutter/material.dart';
import 'package:tasktime_bloc/src/models/task_model.dart';
import 'package:tasktime_bloc/utils/helpers/date_helper.dart';
import 'package:tasktime_bloc/utils/ui/animations/card_expansion_animation.dart';

class TaskDetails extends StatefulWidget{
  final TaskItem task;
  final Animation caeAnimation;
  TaskDetails({Key key, @required this.task, @required this.caeAnimation}): super(key: key);
  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails>{

  @override
  Widget build(BuildContext context) {
    var _task = widget.task;
    return SizeTransition(
        axisAlignment: 1.0,
        sizeFactor: widget.caeAnimation,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 1.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                    text: TextSpan(
                        text: _task.taskDescription,
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle2
                    )
                ),
                //SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                            text: printDate(_task.creationDate),
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle2
                        )
                    ),
                    RichText(
                        text: TextSpan(
                            text: ' - ',
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle2
                        )
                    ),
                    RichText(
                        text: TextSpan(
                            text: printDate(_task.deadlineDate),
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle2
                        )
                    )
                  ],
                )
              ]
          ),)
    );
  }
}