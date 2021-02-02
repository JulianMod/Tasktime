import 'package:flutter/material.dart';
import 'package:tasktime_bloc/utils/ui/screens/secret_screen.dart';
import 'package:tasktime_bloc/utils/ui/screens/settings_screen.dart';
import 'package:tasktime_bloc/utils/ui/screens/task_list_screen.dart';
import 'package:tasktime_bloc/utils/ui/screens/task_screen.dart';
import 'package:tasktime_bloc/utils/ui/screens/timer_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    //var onboardingCompleted = applicationPreferences?.getBool('onboardingCompleted') ?? false;
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => TaskListScreen());
      case '/task_entry':
        return MaterialPageRoute(builder: (context) =>
            TaskScreen(
              //data_package contains: task and string for the FAB
              dataPackage: args,
            )
        );
      case '/timer_screen':
        return MaterialPageRoute(builder: (context) =>
            TimerScreen(
              task: args,
            )
        );
      case '/settings_screen':
        return MaterialPageRoute(builder: (context) =>
            SettingsScreen()
        );
      case '/secret_screen':
        return MaterialPageRoute(builder: (context) => SecretScreen());
      default:  /*if (onboardingCompleted == false) {
        return MaterialPageRoute(builder: (context) => OnboardingScreen());
      }*/
        return MaterialPageRoute(builder: (_) => TaskListScreen());
    }
  }
/*static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }*/
}