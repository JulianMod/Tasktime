import 'package:flutter/material.dart';
import 'package:tasktime_bloc/src/models/task_model.dart';
import 'package:tasktime_bloc/utils/ui/components/timer_extension_button.dart';

class TimerDescriptionTimerExtension extends StatelessWidget {
  const TimerDescriptionTimerExtension({Key key, this.t, this.callback}) : super(key: key);
  final TaskItem t;
  final Function callback;

  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: Duration(seconds: 1),
      firstChild: Row(
          children: [
            Container(
                alignment: Alignment.topCenter,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 100,
                child: RichText(
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: t.taskDescription,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline6
                    )
                )
            )
          ]
      ),
      secondChild: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerExtensionButton(
                t: t,
                callback: callback,
                extensionTime: Duration(minutes: 4, seconds: 59),
                timeDisplayed: '+5'),
            TimerExtensionButton(
                t: t,
                callback: callback,
                extensionTime: Duration(minutes: 14, seconds: 59),
                timeDisplayed: '+15'),
            TimerExtensionButton(
                t: t,
                callback: callback,
                extensionTime: Duration(minutes: 29, seconds: 59),
                timeDisplayed: '+30')
          ]
      ),
      crossFadeState: (t.durationTime.inSeconds != 0) ? CrossFadeState
          .showFirst : CrossFadeState.showSecond,
    );
  }
}