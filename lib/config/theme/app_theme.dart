import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(letterSpacing: -0.9),
      bodyMedium: TextStyle(letterSpacing: -0.9),
      headlineLarge: TextStyle(letterSpacing: -0.9),
      headlineMedium: TextStyle(letterSpacing: -0.9),
      titleMedium: TextStyle(letterSpacing: -0.9),
      titleSmall: TextStyle(letterSpacing: -0.9),
    ),
  );
}
