import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tasktime_bloc/src/models/task_model.dart';
import 'package:tasktime_bloc/utils/ui/animations/card_expansion_animation.dart';

class TaskEntryImage extends StatefulWidget{
  final TaskItem task;
  final Animation caeAnimation;
  TaskEntryImage({Key key,@required this.task, @required this.caeAnimation}) : super(key:key);
  @override
  _TaskEntryImageState createState() => _TaskEntryImageState();
}

class _TaskEntryImageState extends State<TaskEntryImage>{

  @override
  Widget build(BuildContext context) {
    var imagePath = widget.task.taskImagePath;
    if(imagePath.isNotEmpty) {
      return
        SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: widget.caeAnimation,
            child:
            Column(
                children: [
                  Image.file(File(imagePath)),
                  SizedBox(height: 10)]
            )
        );
    }
    else{
      return Container(height: 1);
    }
  }
}