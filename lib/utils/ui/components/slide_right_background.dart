import 'package:flutter/material.dart';
import 'package:tasktime_bloc/core/settings/settings.dart';

Widget slideRightBackground() {
  return Container(
      color: (themeMode == 'Light') ?
      Colors.green[300] :
      Color(0xFF314c31),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              Text(
                " Edit",
                style: (themeMode == 'Light') ?
                TextStyle(fontWeight: FontWeight.w700, color: Colors.teal[50]) :
                TextStyle(fontWeight: FontWeight.w700, color: Colors.lightBlue[100]),
                textAlign: TextAlign.left,
              ),
              Icon(Icons.edit)
            ],
          )
      )
  );
}