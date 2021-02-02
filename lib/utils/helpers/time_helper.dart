
String printTimerTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  var twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  return '${twoDigits(duration.inHours)}:$twoDigitMinutes';
}

int calculateTimeInSeconds(_duration) {
  int _durationSecondsTimer = _duration % 60;
  return _durationSecondsTimer;
}

int calculateTimeInMinutes(_duration) {
  //_duration is provided as Duration in seconds
  int _durationMinutesTimer = _duration ~/ 60 % 60;
  return _durationMinutesTimer;
}

int calculateTimeInHours(_duration) {
  int _durationHoursTimer = _duration ~/ 3600;
  return _durationHoursTimer;
}