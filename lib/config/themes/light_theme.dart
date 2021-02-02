import 'package:flutter/material.dart';
import 'package:tasktime_bloc/core/settings/settings.dart';

var lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.teal[900],
    accentColor: Colors.cyan[800],
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.teal[50],
    splashColor: Colors.orange[300],
    highlightColor: Colors.orange[300],
    cursorColor: Colors.orange[300],
    textTheme: TextTheme(
        headline6: TextStyle(
            color: Colors.teal[900],
            fontSize: mainFontSize,
            fontWeight: FontWeight.normal
        ), //main text
        subtitle2: TextStyle(
            color: Colors.teal[700],
            fontSize: mainFontSize / 3 * 2,
            fontWeight: FontWeight.normal
        ),
        //main duration text color
        headline2: TextStyle(
            color: Colors.teal[900]),
        //main duration subtext color
        bodyText2: TextStyle(
            color: Colors.teal[900]),
        //circular minutes test color
        subtitle1: TextStyle(
            color: Colors.teal[700])
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        labelStyle: TextStyle(
            color: Colors.teal[700],
            fontSize: mainFontSize / 3 * 2,
            fontWeight: FontWeight.normal
        ),
        filled: true,
        fillColor: Colors.white
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
            side: BorderSide(
                color: Colors.teal[900],
                width: 1)
        )
    ),
    appBarTheme: AppBarTheme(
        color: Colors.teal[900],
        iconTheme: IconThemeData(color: Colors.teal[50]),
        actionsIconTheme: IconThemeData(color: Colors.teal[50]),
        textTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.teal[50],
                fontSize: mainFontSize,
                fontWeight: FontWeight.bold
            )
        )
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.teal[50],
        backgroundColor: Colors.cyan[800]
    ),
    iconTheme: IconThemeData(color: Colors.teal[50]),
    //for the date and duration pickers
    colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        //today's date, chosen date and Ok/Cancel text color
        primary: Colors.teal[900],
        //date duration head color
        surface: Colors.teal[900],
        //chosen date text color
        onPrimary: Colors.teal[50],
        //title, shorten date and month display test color
        onSurface: Colors.teal[900]
    ),
    dialogBackgroundColor: Colors.teal[50],
    //duration picker inner circle color
    canvasColor: Colors.teal[50],
    //duration picker outer circle background color, highlight is taken from accent
    backgroundColor: Colors.white,
    sliderTheme: SliderThemeData(
        valueIndicatorColor: Colors.white,
        valueIndicatorTextStyle: TextStyle(
            color: Colors.teal[900]
        )
    )
);