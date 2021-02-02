import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasktime_bloc/src/app.dart';
import 'config/themes/theme_config.dart';
import 'core/settings/settings.dart';

void main() async {
  retrievePreferences();

  runApp(
      ChangeNotifierProvider<ThemeProvider>(
        create: (context) => ThemeProvider(),
        child: TaskListApp(),
      )
  );
}