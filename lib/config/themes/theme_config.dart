import 'package:flutter/material.dart';
import 'package:tasktime_bloc/config/themes/secret_theme.dart';
import 'package:tasktime_bloc/core/settings/settings.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

class ThemeProvider with ChangeNotifier {

  ThemeData lightThemeChooser() {
    if(themeMode == 'Extra'){
      return extraTheme;
    }
    return lightTheme;
  }

  ThemeData darkThemeChooser() {

    if(themeMode == 'Extra'){
      return extraTheme;
    }
    return darkTheme;
  }

  ThemeMode currentTheme() {
    var currentHour = DateTime.now().hour;

    //if the manual theme switching mode is one choose the one from radio picker in settings
    //if the automatic mode is one choose the theme according to an hour(light between 7 and 20)
    if (themeModeAutomatic == false){
      if (themeMode == 'Light'){
        return ThemeMode.light;
      }
      if (themeMode == 'Dark'){
        return ThemeMode.dark;
      }
    }
    if (themeModeAutomatic == true){
      if (currentHour>= 7 && currentHour <= 20){
        return ThemeMode.light;
      }
      if (currentHour > 20 || currentHour < 7){
        return ThemeMode.dark;
      }
    }
    return ThemeMode.system;
  }

  void changeThemes(newThemeMode) async {
    themeMode = newThemeMode;
    notifyListeners();
  }

  void rebuildTheApp() async {
    notifyListeners();
  }
}