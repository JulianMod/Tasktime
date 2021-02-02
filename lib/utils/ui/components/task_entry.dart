import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasktime_bloc/src/models/task_model.dart';
import 'package:tasktime_bloc/src/resources/database_provider.dart';
import 'package:tasktime_bloc/utils/ui/animations/card_expansion_animation.dart';
import 'package:tasktime_bloc/utils/ui/components/task_details.dart';
import 'package:tasktime_bloc/utils/ui/components/task_duration_status_display.dart';
import 'package:tasktime_bloc/utils/ui/components/task_image.dart';
import 'package:vibration/vibration.dart';

class TaskListEntry extends StatefulWidget{
  final TaskItem task;
  TaskListEntry({Key key, @required this.task}): super(key: key);
  @override
  _TaskListEntryState createState() => _TaskListEntryState();
}

class _TaskListEntryState extends State<TaskListEntry> with SingleTickerProviderStateMixin{
  CardExpansionAnimation _cardExpansionAnimation;

  @override
  void initState() {
    super.initState();
    _cardExpansionAnimation = CardExpansionAnimation();
    _cardExpansionAnimation.animationInitialization(this);
    _cardExpansionAnimation.runExpandCheck(widget.task.expanded);
  }

  @override
  void dispose(){
    _cardExpansionAnimation.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _task = widget.task;
    return InkWell(
        onTap: () {
          HapticFeedback.mediumImpact();
          if (_task.expanded == false) {
            _task.expanded = true;
          }
          else {
            _task.expanded = false;
          }
          dbUpdate(_task);
          _cardExpansionAnimation.runExpandCheck(widget.task.expanded);
        },
        onDoubleTap: () {
          if (_task.status == false) {
            Vibration.vibrate(duration: 100, amplitude: 255);
            Navigator.of(this.context).pushNamed(
                '/timer_screen', arguments: _task).then((result) {
              setState(() {});
            });
          }
        },
        child: Card(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TaskEntryImage(task: _task, caeAnimation: _cardExpansionAnimation.animation),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 3,
                              child: RichText(
                                  maxLines: 2,
                                  text: TextSpan(
                                      text: _task.taskName,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline6
                                  )
                              )
                          ),
                          SizedBox(width: 10),
                          Expanded(
                              flex: 0,
                              child: TaskDurationStatusDisplay(task: _task,)),
                          //SizedBox(width: 10)
                        ],
                      ),
                      Row(
                          children: <Widget>[
                            Expanded(
                                child: TaskDetails(task: _task, caeAnimation: _cardExpansionAnimation.animation)
                            )
                          ]
                      )
                    ]
                )
            )
        )
    );
  }
}