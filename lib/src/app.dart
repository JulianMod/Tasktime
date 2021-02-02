import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasktime_bloc/config/routes/routes.dart';
import 'package:tasktime_bloc/config/themes/theme_config.dart';

class TaskListApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    final themeProvider = Provider.of<ThemeProvider>(context);

    void counting(Timer timer) {
      if(DateTime.now().hour == 7 && DateTime.now().minute == 0 && DateTime.now().second == 0){
        themeProvider.rebuildTheApp();
      }
      if(DateTime.now().hour == 21 && DateTime.now().minute == 0 && DateTime.now().second == 0){
        themeProvider.rebuildTheApp();
      }
    }

    var timer = Timer.periodic(const Duration(seconds: 1), counting);

    return MaterialApp(
      title: 'Task List',
      //debugShowCheckedModeBanner: false,
      theme: themeProvider.lightThemeChooser(),
      darkTheme: themeProvider.darkThemeChooser(),
      themeMode: themeProvider.currentTheme(),
      //initialRoute: '/home',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}