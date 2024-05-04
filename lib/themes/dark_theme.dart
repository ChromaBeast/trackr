import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900],
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.white,
    ),
  ),
);
