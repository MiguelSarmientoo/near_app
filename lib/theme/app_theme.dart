import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.light(
        secondary: Colors.blueAccent, // Color de acento
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold), // Uso de headlineLarge
        bodyLarge: TextStyle(fontSize: 16.0), // bodyText1
        bodyMedium: TextStyle(fontSize: 14.0), // bodyText2
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.blueGrey,
      colorScheme: ColorScheme.dark(
        secondary: Colors.redAccent, // Color de acento para el tema oscuro
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
        bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white70),
      ),
    );
  }
}
