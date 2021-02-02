/*
import 'dart:async';

import 'package:tasktime_bloc/core/settings/settings.dart';
import 'package:tasktime_bloc/src/models/task_model.dart';
import 'package:tasktime_bloc/src/resources/database_provider.dart';
import 'package:tasktime_bloc/utils/helpers/time_helper.dart';
import 'package:vibration/vibration.dart';

void startTimer(TaskItem t) {
  //maybe startTimer should be run in Isolate?
  //the timer could be also done using Ticker
  //var _currentTask = widget.task;
  const oneSec = Duration(seconds: 1);
  var initialDuration = t.durationTime.inSeconds;

  void counting(Timer timer) {
    if (durationSeconds < 1) {
      timer.cancel();
      //_pulseAnimationController.stop;
      t.durationTime = Duration(hours: calculateTimeInHours(),
          minutes: calculateTimeInMinutes(durationSeconds),
          seconds: calculateTimeInSeconds());
      t.status = true;
      //FlutterRingtonePlayer.playAlarm();
      dbUpdate(t);
      if (mounted) {
        setState(() {});
      }
      tpa.resetAnimation();
      Vibration.vibrate(pattern: [0, 500, 500, 500, 500, 500, 500, 500, 500, 500], amplitude: 128);
    }
    else {
      if((calculateTimeInMinutes(initialDuration)-calculateTimeInMinutes(durationSeconds)) % timerAwarenessInterval == 0 && calculateTimeInSeconds() == 0) {
        Vibration.vibrate(duration: 100, amplitude: 128);
      }
      durationSeconds = durationSeconds - 1;
      //this part can affect the performance heavily
      dbUpdate(t);
      t.durationTime = Duration(hours: calculateTimeInHours(),
          minutes: calculateTimeInMinutes(durationSeconds),
          seconds: calculateTimeInSeconds());
      if (mounted) {
        setState(() {});
      }
    }
  }
  _timer = Timer.periodic(oneSec, counting);
}*/
