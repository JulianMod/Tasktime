import 'package:flutter/material.dart';
import 'package:tasktime_bloc/core/settings/settings.dart';

var darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue[100],
    accentColor: Colors.white,
    cardColor: Color(0xFF001533),
    scaffoldBackgroundColor: Color(0xFF000e21),
    splashColor: Colors.orange[300],
    highlightColor: Colors.orange[300],
    cursorColor: Colors.orange[300],
    textTheme: TextTheme(
        headline6: TextStyle(
            color: Colors.lightBlue[100],
            fontSize: mainFontSize,
            fontWeight: FontWeight.normal
        ), //main text
        subtitle2: TextStyle(
            color: Color(0xFF6b8a96),
            fontSize: mainFontSize / 3 * 2,
            fontWeight: FontWeight.normal
        ),
        //main duration text color
        headline2: TextStyle(
            color: Colors.white),
        //main duration subtext color
        bodyText2: TextStyle(
            color: Colors.white),
        //circular minutes test color
        subtitle1: TextStyle(
            color: Colors.lightBlue[100])
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        labelStyle: TextStyle(
            color: Color(0xFF6b8a96),
            fontSize: mainFontSize / 3 * 2,
            fontWeight: FontWeight.normal
        ),
        filled: true,
        fillColor: Color(0xFF001533)
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            backgroundColor: Color(0xFF6b8a96),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
            side: BorderSide(
                color: Colors.white,
                width: 1)
        )
    ),
    appBarTheme: AppBarTheme(
        color: Color(0xFF02193f),
        iconTheme: IconThemeData(color: Colors.lightBlue[100]),
        actionsIconTheme: IconThemeData(color: Colors.lightBlue[100]),
        textTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.lightBlue[100],
                fontSize: mainFontSize,
                fontWeight: FontWeight.bold
            )
        )
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.lightBlue[100],
        backgroundColor: Color(0xFF003135)
    ),
    unselectedWidgetColor: Color(0xFF001533),
    toggleableActiveColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.lightBlue[100]),
    //for the date and duration pickers
    colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        //today's date, chosen date and Ok/Cancel text color
        primary: Colors.white,
        //date duration head color
        surface: Color(0xFF02193f),
        //chosen date text color
        onPrimary: Color(0xFF02193f),
        //title, shorten date and month display test color
        onSurface: Colors.lightBlue[100]
    ),
    dialogBackgroundColor: Color(0xFF000e21),
    //duration picker inner circle color
    canvasColor: Color(0xFF000e21),
    //duration picker outer circle background color, highlight is taken from accent
    backgroundColor: Color(0xFF02193f),
    sliderTheme: SliderThemeData(
        valueIndicatorColor: Color(0xFF001533),
        valueIndicatorTextStyle: TextStyle(
            color: Colors.lightBlue[100]
        )
    )
);