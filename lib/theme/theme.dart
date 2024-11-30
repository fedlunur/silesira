import 'package:flutter/material.dart';

class AppTheme {
  static const TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
    headlineSmall: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    bodyLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black),
    bodyMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
    bodySmall: TextStyle(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
  );

  static const TextTheme darkTextTheme = TextTheme(
    headlineLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    headlineSmall: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    bodyLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),
    bodyMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
    bodySmall: TextStyle(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
  );

  static const Color customColor = Color.fromARGB(255, 63, 114, 175);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: customColor,
      brightness: Brightness.light,
    ),
    textTheme: lightTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: customColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: customColor,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: customColor,
      brightness: Brightness.dark,
    ),
    textTheme: darkTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: customColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: customColor,
      ),
    ),
  );
}
