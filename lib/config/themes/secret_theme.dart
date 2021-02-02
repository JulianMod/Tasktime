import 'package:flutter/material.dart';
import 'package:tasktime_bloc/core/settings/settings.dart';

var extraTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    accentColor: Colors.white,
    cardColor: Colors.grey[400],
    scaffoldBackgroundColor: Colors.teal[400],
    splashColor: Colors.lightBlue[300],
    highlightColor: Colors.lightBlue[300],
    cursorColor: Colors.black,
    textTheme: TextTheme(
        headline6: TextStyle(
            color: Colors.black,
            fontSize: mainFontSize,
            fontWeight: FontWeight.normal
        ), //main text
        subtitle2: TextStyle(
            color: Colors.black,
            fontSize: (mainFontSize) / 3 * 2,
            fontWeight: FontWeight.normal
        ), // secondary text
        //main duration text color
        headline2: TextStyle(
            color: Colors.black),
        //main duration subtext color
        bodyText2: TextStyle(
            color: Colors.black),
        //circular minutes test color
        subtitle1: TextStyle(
            color: Colors.black)
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        labelStyle: TextStyle(
            color: Colors.black,
            fontSize: (mainFontSize) / 3 * 2,
            fontWeight: FontWeight.normal
        ),
        filled: true,
        fillColor: Colors.grey[400]
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.grey[400],
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
            side: BorderSide(
                color: Colors.grey[200],
                width: 1)
        )
    ),
    appBarTheme: AppBarTheme(
        color: Colors.blue[900],
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.white,
                fontSize: mainFontSize,
                fontWeight: FontWeight.bold
            )
        )
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.black,
        backgroundColor: Colors.grey[400]
    ),
    iconTheme: IconThemeData(color: Colors.white),
    //for the date and duration pickers
    colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        //today's date, chosen date and Ok/Cancel text color
        primary: Colors.blue[900],
        //date duration head color
        surface: Colors.white,
        //chosen date text color
        onPrimary: Colors.white,
        //title, shorten date and month display test color
        onSurface: Colors.black
    ),
    dialogBackgroundColor: Colors.grey,
    //duration picker inner circle color
    canvasColor: Colors.grey,
    //duration picker outer circle background color, highlight is taken from accent
    backgroundColor: Colors.blue[900],
    sliderTheme: SliderThemeData(
        thumbColor: Colors.white,
        activeTrackColor: Colors.white,
        inactiveTrackColor: Colors.grey,
        valueIndicatorColor: Colors.blue[900],
        valueIndicatorTextStyle: TextStyle(
            color: Colors.white
        )
    )
);