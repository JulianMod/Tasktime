import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasktime_bloc/config/themes/theme_config.dart';
import 'package:tasktime_bloc/core/settings/settings.dart';

class TwoThemeButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      children: [
        Expanded(
            child: Row(
                children: <Widget>[
                  Radio(
                    groupValue: themeMode,
                    value: 'Light',
                    onChanged: (newValue) {
                      applicationPreferences.setString('theme', newValue);
                      themeProvider.changeThemes(newValue);
                    },
                  ),
                  Text('Light',
                      style: Theme.of(context).textTheme.headline6)
                ]
            )
        ),
        Expanded(
            child: Row(
                children: <Widget>[
                  Radio(
                    groupValue: themeMode,
                    value: 'Dark',
                    onChanged: (newValue) {
                      applicationPreferences.setString('theme', newValue);
                      themeProvider.changeThemes(newValue);
                    },
                  ),
                  Text('Dark',
                      style: Theme.of(context).textTheme.headline6)
                ]
            )
        )
      ],
    );
  }
}

