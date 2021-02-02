import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

SharedPreferences applicationPreferences;

void retrievePreferences() async {
  WidgetsFlutterBinding.ensureInitialized();
  applicationPreferences = await SharedPreferences?.getInstance();
}

var mainFontSize = applicationPreferences?.getDouble('fontSize') ?? 24;
var timerAwarenessInterval = applicationPreferences?.getDouble('timerInterval') ?? 15;
var numberOfTasksCompleted = applicationPreferences?.getInt('tasksCompleted') ?? 0;
var themeModeAutomatic = applicationPreferences?.getBool('themeModeAutomatic') ?? true;
var themeMode = applicationPreferences?.getString('theme') ?? 'Light';
var finalSecretUnlocked = applicationPreferences?.getBool('finalSecretStatus') ?? false;