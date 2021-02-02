import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasktime_bloc/core/settings/settings.dart';
import 'package:tasktime_bloc/src/resources/database_provider.dart';
import 'package:tasktime_bloc/utils/ui/animations/timer_pulse_animation.dart';
import 'package:tasktime_bloc/utils/ui/components/task_description_timer_extension.dart';
import 'package:vibration/vibration.dart';
import 'package:wakelock/wakelock.dart';
import 'package:tasktime_bloc/src/models/task_model.dart';
import 'package:tasktime_bloc/utils/helpers/time_helper.dart';

class TimerScreen extends StatefulWidget {
  final TaskItem task;
  TimerScreen({Key key, @required this.task}): super(key:key);
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> with SingleTickerProviderStateMixin{
  Timer _timer;
  int durationSeconds;
  bool timerIsPaused = false;
  TimerPulse tpa;

  void startTimer() {
    //the timer could be also done using Ticker
    var _currentTask = widget.task;
    const oneSec = Duration(seconds: 1);
    var initialDuration = durationSeconds;

    void counting(Timer timer) {
      if (durationSeconds < 1) {
        timer.cancel();
        //_pulseAnimationController.stop;
        _currentTask.durationTime = Duration(hours: calculateTimeInHours(durationSeconds),
            minutes: calculateTimeInMinutes(durationSeconds),
            seconds: calculateTimeInSeconds(durationSeconds));
        _currentTask.status = true;
        //FlutterRingtonePlayer.playAlarm();
        dbUpdate(_currentTask);
        if (mounted) {
          setState(() {});
        }
        tpa.stopAnimation();
        Vibration.vibrate(pattern: [0, 500, 500, 500, 500, 500, 500, 500, 500, 500], amplitude: 128);
      }
      else {
        if((calculateTimeInMinutes(initialDuration)-calculateTimeInMinutes(durationSeconds)) % timerAwarenessInterval == 0 && calculateTimeInSeconds(durationSeconds) == 0) {
          Vibration.vibrate(duration: 100, amplitude: 128);
        }
        durationSeconds = durationSeconds - 1;
        //this part can affect the performance heavily
        dbUpdate(_currentTask);
        _currentTask.durationTime = Duration(hours: calculateTimeInHours(durationSeconds),
            minutes: calculateTimeInMinutes(durationSeconds),
            seconds: calculateTimeInSeconds(durationSeconds));
        if (mounted) {
          setState(() {});
        }
      }
    }
    _timer = Timer.periodic(oneSec, counting);
  }

  timeExtensionCallback(){
    var _currentTask = widget.task;
    setState(() {
      durationSeconds = _currentTask.durationTime.inSeconds;
      dbUpdate(_currentTask);
      startTimer();
      tpa.startAnimation();
    });
  }

  @override
  void initState() {
    super.initState();
    tpa = TimerPulse();
    Wakelock.enable();
    var _currentTask = widget.task;
    durationSeconds = _currentTask.durationTime.inSeconds;
    tpa.animationInitialization(this, durationSeconds);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => startTimer());
  }

  @override
  void dispose() {
    if (durationSeconds == 0){
      numberOfTasksCompleted += 1;
      applicationPreferences.setInt('tasksCompleted', numberOfTasksCompleted);
    }
    tpa.disposeController();
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _currentTask = widget.task;

    Widget TimerCounter() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Expanded(
              flex: 1,
              child: SizedBox()
          ),
            Expanded(
                flex: 3,
                child: Stack (
                    alignment: Alignment.center,
                    children: <Widget>[
                      tpa.buildWidget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //time in hours
                          RichText(
                              key: UniqueKey(),
                              text: TextSpan(
                                  text: calculateTimeInHours(durationSeconds).toString().padLeft(2, '0'),
                                  style: Theme.of(context).textTheme.headline6.copyWith(
                                      fontSize: 20
                                  )
                              )
                          ),
                          SizedBox(width: 10),
                          //time in minutes
                          //maybe it should be separate widget
                          InkResponse(
                              radius: 100,
                              highlightShape: BoxShape.circle,
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                if (durationSeconds < 1) {
                                  //FlutterRingtonePlayer.stop();
                                }
                                else {
                                  if (_timer.isActive == true) {
                                    timerIsPaused = true;
                                    tpa.stopAnimation();
                                    _timer.cancel();
                                  }
                                  else {
                                    timerIsPaused = false;
                                    startTimer();
                                    tpa.continueAnimation();
                                  }
                                }
                                setState(() {});
                              },
                              child: AnimatedSwitcher(//not working
                                  duration: const Duration(seconds: 1),
                                  transitionBuilder: (Widget child, Animation<double> animation) {
                                    return ScaleTransition(
                                        child: child,
                                        scale: animation);
                                  },
                                  child: RichText(
                                      key: ValueKey(calculateTimeInMinutes(durationSeconds)),
                                      text: TextSpan(
                                        //show time in minutes
                                          text: calculateTimeInMinutes(durationSeconds).toString().padLeft(2, '0'),
                                          style: Theme.of(context).textTheme.headline6.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 150
                                          )
                                      )
                                  )
                              )
                          ),
                          SizedBox(width: 10),
                          //time in seconds
                          RichText(
                              key: UniqueKey(),
                              text: TextSpan(
                                  text: calculateTimeInSeconds(durationSeconds).toString().padLeft(2, '0'),
                                  style: Theme.of(context).textTheme.headline6.copyWith(
                                      fontSize: 20
                                  )
                              )
                          ),
                        ],
                      )
                    ]
                )
            ),
            Expanded(flex: 1,
                child:  Align(
                  alignment: Alignment.topCenter,
                  child: TimerDescriptionTimerExtension(t: _currentTask, callback: timeExtensionCallback),
                )
            )
          ]
      );
    }

    return WillPopScope(
        onWillPop: (timerIsPaused == true || durationSeconds < 1) ?
            () async => true :
            () async => false,
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text(_currentTask.taskName),
                automaticallyImplyLeading:  false,
                leading: (timerIsPaused == true || durationSeconds < 1) ?
                BackButton(
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      //FlutterRingtonePlayer.stop();
                      Navigator.of(context).pop();
                    }
                ) :
                Container()
            ),
            body: (_currentTask.taskImagePath.isNotEmpty) ?
            PageView(
                children: [
                  TimerCounter(),
                  Image.file(File(_currentTask.taskImagePath))
                ]
            )
                :
            TimerCounter()
        )
    );
  }
}


