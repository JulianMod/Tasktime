import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasktime_bloc/config/themes/theme_config.dart';
import 'package:tasktime_bloc/core/settings/settings.dart';

class ThreeThemeButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio(
                visualDensity: VisualDensity.compact,
                groupValue: themeMode,
                value: 'Light',
                onChanged: (newValue) {
                  applicationPreferences.setString('theme', newValue);
                  themeProvider.changeThemes(newValue);
                },
              ),
              Text('Light',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6)
            ]
        ),
        Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio(
                visualDensity: VisualDensity.compact,
                groupValue: themeMode,
                value: 'Dark',
                onChanged: (newValue) {
                  applicationPreferences.setString('theme', newValue);
                  themeProvider.changeThemes(newValue);
                },
              ),
              Text('Dark',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6)
            ]
        ),
        Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio(
                visualDensity: VisualDensity.compact,
                groupValue: themeMode,
                value: 'Extra',
                onChanged: (newValue) {
                  applicationPreferences.setString('theme', newValue);
                  themeProvider.changeThemes(newValue);
                },
              ),
              Text('Extra',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6)
            ]
        )
      ],
    );
  }
}


