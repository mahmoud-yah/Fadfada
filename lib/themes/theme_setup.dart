import 'package:flutter/material.dart';

List<ThemeData> getThemes() {
  return [
    ThemeData(backgroundColor: Colors.black,primaryColor: Colors.white ,accentColor: Colors.lightGreenAccent,brightness: Brightness.dark,),
    ThemeData(backgroundColor: Colors.white,primaryColor: Colors.red, accentColor: Colors.green),
    ThemeData(backgroundColor: Colors.purple,primaryColor: Colors.red, accentColor: Colors.green),
    ThemeData(backgroundColor: Colors.black,primaryColor: Colors.red, accentColor: Colors.red),
    ThemeData(backgroundColor: Colors.red,primaryColor: Colors.red, accentColor: Color(0xFFFEF9EB),),
    ThemeData(backgroundColor: Colors.white,primaryColor: Colors.black,accentColor: Colors.green,brightness: Brightness.light,),
  ];
}