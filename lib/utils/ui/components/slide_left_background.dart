import 'package:flutter/material.dart';
import 'package:tasktime_bloc/core/settings/settings.dart';

Widget slideLeftBackground() {
  return Container(
      color: (themeMode == 'Light') ?
      Colors.red[300] :
      Color(0xFF4f2727),
      child: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Delete",
                style: (themeMode == 'Light') ?
                TextStyle(fontWeight: FontWeight.w700, color:Colors.teal[50]) :
                TextStyle(fontWeight: FontWeight.w700, color: Colors.lightBlue[100]),
                textAlign: TextAlign.right,
              ),
              Icon(Icons.delete),
              SizedBox(width: 20)
            ],
          )
      )
  );
}