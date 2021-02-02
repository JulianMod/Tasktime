import 'package:flutter/material.dart';
import 'package:tasktime_bloc/src/models/task_model.dart';


class TimerExtensionButton extends StatelessWidget {
  const TimerExtensionButton({Key key, this.t, this.callback, this.extensionTime, this.timeDisplayed}) : super(key: key);
  final String timeDisplayed;
  final Duration extensionTime;
  final TaskItem t;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          t.durationTime = extensionTime;
          t.status = false;
          callback();
        },
        child: RichText(
            text: TextSpan(
                text: timeDisplayed,
                style: Theme.of(context).textTheme.headline6
            )
        )
    );
  }
}

