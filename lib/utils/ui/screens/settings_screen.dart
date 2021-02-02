import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tasktime_bloc/config/themes/theme_config.dart';
import 'package:tasktime_bloc/core/settings/settings.dart';
import 'package:tasktime_bloc/utils/ui/components/code_input.dart';
import 'package:tasktime_bloc/utils/ui/components/theme_choice.dart';

class SettingsScreen extends StatefulWidget{
  SettingsScreen({Key key}): super(key:key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>{
  bool firstSecretUnlocked = false;
  var myControllerYearInput = TextEditingController();
  int tasksCompletedTapCounter = 0;

  @override
  void dispose() {
    myControllerYearInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Settings'),
          actions: firstSecretUnlocked == true ?
          <Widget>[IconButton(
            icon: Icon(
              Icons.cake,
              color: Colors.red,
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              showDialog(
                  context: context,
                  builder:  (BuildContext context) {
                    return Dialog(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Container(
                              alignment: Alignment.centerLeft,
                              color: Colors.blue[900],
                              padding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 30
                              ),
                              child: RichText(
                                  text: TextSpan(
                                      text: 'Input a year',
                                      style: Theme.of(context).textTheme.headline6.copyWith(
                                          color: Colors.white
                                      )
                                  )
                              ),
                            ),
                              Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 30),
                                  child: CodeInput()
                              )
                            ]
                        )
                    );
                  }
              );
            },
          )
          ] :
          []
      ),
      body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(8.0),
          children: [Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child:
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          RichText(
                              text: TextSpan(
                                  text: 'Switch themes \nautomatically',
                                  style: Theme.of(context).textTheme.subtitle2
                              )
                          ),
                          Switch(
                              value: themeModeAutomatic,
                              onChanged: (newValue) {
                                themeModeAutomatic = newValue;
                                applicationPreferences.setBool('themeModeAutomatic', themeModeAutomatic);
                                themeProvider.rebuildTheApp();
                              }
                          )
                        ]
                    ),
                    Divider(height: 10),
                    RichText(
                        text: TextSpan(
                            text: 'Choose application theme',
                            style: Theme.of(context).textTheme.subtitle2
                        )
                    ),
                    ThemeChoiceButtons(),
                    Divider(height: 30),
                    RichText(
                        text: TextSpan(
                            text: 'Choose font size',
                            style: Theme.of(context).textTheme.subtitle2
                        )
                    ),
                    Slider(
                        value: mainFontSize,
                        min: 16,
                        max: 32,
                        divisions: 2,
                        label: mainFontSize.round().toString(),
                        onChanged: (double newValue) {
                          mainFontSize = newValue;
                          applicationPreferences.setDouble('fontSize', mainFontSize);
                          themeProvider.rebuildTheApp();
                        }
                    ),
                    Divider(height: 30),
                    RichText(
                        text: TextSpan(
                            text: 'Choose timer awareness interval',
                            style: Theme.of(context).textTheme.subtitle2
                        )
                    ),
                    Slider(
                        value: timerAwarenessInterval,
                        min: 1,
                        max: 60,
                        divisions: 60,
                        label: timerAwarenessInterval.round().toString(),
                        onChanged: (double newValue) {
                          setState(() {
                            timerAwarenessInterval = newValue;
                            applicationPreferences.setDouble('timerInterval', timerAwarenessInterval);
                          });
                        }
                    ),
                    Divider(height: 30),
                    GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          tasksCompletedTapCounter +=1;
                          if(tasksCompletedTapCounter == 3){
                            setState(() {
                              firstSecretUnlocked = true;
                            });
                          }
                        },
                        child: RichText(
                            text: TextSpan(
                                text: 'Tasks completed: $numberOfTasksCompleted',
                                style: Theme.of(context).textTheme.subtitle2
                            )
                        )
                    )
                  ]
              )
          )
          ]
      ),
    );
  }
}