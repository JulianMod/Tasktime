String printDate(DateTime dateTime){
  String _twoDigits(int n) => n.toString().padLeft(2, "0");
  String _fourDigits(int n) => n.toString().padLeft(4, "0");
  String y = _fourDigits(dateTime.year);
  String m = _twoDigits(dateTime.month);
  String d = _twoDigits(dateTime.day);
  return '$d/$m/$y';
}