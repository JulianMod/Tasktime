import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasktime_bloc/src/models/task_model.dart';
import 'package:tasktime_bloc/utils/helpers/date_helper.dart';
import 'package:tasktime_bloc/utils/helpers/time_helper.dart';
import 'package:tasktime_bloc/utils/ui/components/duration_picker.dart';
import 'package:tasktime_bloc/utils/ui/components/thumbnail.dart';

class TaskScreen extends StatefulWidget {
  //data_package contains task and String for FAB
  final List dataPackage;
  TaskScreen({Key key, @required this.dataPackage}): super(key: key);
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>{
  var myControllerTaskName = TextEditingController();
  var myControllerTaskDescription = TextEditingController();
  var myControllerDuration = TextEditingController();
  var myControllerCreationDate = TextEditingController();
  var myControllerDeadlineDate = TextEditingController();
  var todayDate = DateTime.now();

  void dispose() {
    ///to clean the controller after work is done
    myControllerTaskName.dispose();
    myControllerTaskDescription.dispose();
    myControllerDuration.dispose();
    myControllerCreationDate.dispose();
    myControllerDeadlineDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //maybe there is more elegant method to edit the task then create placeholder
    TaskItem _currentTask = widget.dataPackage[0];
    myControllerTaskName.text =  _currentTask.taskName;
    myControllerTaskDescription.text = _currentTask.taskDescription;
    myControllerDuration.text = printTimerTime(_currentTask.durationTime);
    myControllerCreationDate.text = printDate(_currentTask.creationDate);
    myControllerDeadlineDate.text = printDate(_currentTask.deadlineDate);
    final screenSize =  WidgetsBinding.instance.window.physicalSize / WidgetsBinding.instance.window.devicePixelRatio;

    return  Scaffold(
        appBar: AppBar(
          title: Text('Task Entry'),
        ),
        body: ListView(
          padding: EdgeInsets.all(8.0),
          shrinkWrap: true,
          children: [
            Thumbnail(
                task: _currentTask,
                imageSize: screenSize
            ),
            SizedBox(height: 35),
            TextField(
              //autofocus: true,
              style: Theme.of(context).textTheme.headline6,
              controller: myControllerTaskName,
              decoration: InputDecoration(
                  labelText: 'Task name'
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: myControllerTaskDescription,
              style: Theme.of(context).textTheme.headline6,
              decoration: InputDecoration(
                  labelText: 'Task description'
              ),
            ),
            SizedBox(height: 35),
            TextField(
              style: Theme.of(context).textTheme.headline6,
              decoration: InputDecoration(
                  labelText:'Duration'
              ),
              onTap: () async {
                //TimerPicker takes colors from the main theme
                //cancel throws null
                _currentTask.durationTime = await showDurationPicker(
                    context: context,
                    initialTime: _currentTask.durationTime) ?? _currentTask.durationTime; // handle null from DurationPicker
                setState(() {
                  _currentTask.taskName = myControllerTaskName.text;
                  _currentTask.taskDescription = myControllerTaskDescription.text;
                });
              },
              controller: myControllerDuration,
              readOnly: true,
            ),
            SizedBox(height : 35),
            TextField(
                style: Theme.of(context).textTheme.headline6,
                decoration: InputDecoration(
                    labelText: 'Task creation date'
                ),
                onTap: () async {
                  _currentTask.creationDate = await showDatePicker(
                    context: context,
                    initialDate: _currentTask.creationDate,
                    firstDate: DateTime(
                        todayDate.year - 1, todayDate.month, todayDate.day),
                    lastDate: DateTime(
                        todayDate.year + 1, todayDate.month, todayDate.day),
                  ) ?? _currentTask.creationDate;
                  setState(() {
                    _currentTask.taskName = myControllerTaskName.text;
                    _currentTask.taskDescription = myControllerTaskDescription.text;
                  });
                },
                controller: myControllerCreationDate,
                readOnly: true
            ),
            SizedBox(height: 20),
            TextField(
                style: Theme.of(context).textTheme.headline6,
                decoration: InputDecoration(
                  labelText: 'Task deadline date',
                ),
                onTap: () async {
                  _currentTask.deadlineDate = await showDatePicker(
                    context: context,
                    initialDate: _currentTask.deadlineDate,
                    firstDate: DateTime(
                        todayDate.year - 1, todayDate.month, todayDate.day),
                    lastDate: DateTime(
                        todayDate.year + 1, todayDate.month, todayDate.day),
                  ) ?? _currentTask.deadlineDate;
                  setState(() {
                    _currentTask.taskName = myControllerTaskName.text;
                    _currentTask.taskDescription = myControllerTaskDescription.text;
                  });
                },
                controller: myControllerDeadlineDate,
                readOnly: true
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
        FloatingActionButton.extended(
          onPressed: () {
            HapticFeedback.mediumImpact();
            _currentTask.taskName = myControllerTaskName.text;
            _currentTask.taskDescription = myControllerTaskDescription.text;
            Navigator.pop(context, _currentTask);
          },
          label: Text(widget.dataPackage[1]),
          icon: Icon(Icons.check),
        ),
        resizeToAvoidBottomInset: true
    );
  }
}