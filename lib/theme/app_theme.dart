import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1C1C1E);
  static const Color accent = Color(0xFF48C1FF);
  static const Color purpleAccent = Color(0xFF7B4BFF);
  static const Color cardBackground = Color(0xFF242424);

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: background,
    primaryColor: accent,
    brightness: Brightness.dark,
    cardColor: cardBackground,
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 14),
      bodyMedium: TextStyle(fontSize: 13, color: Colors.white70),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: surface,
      elevation: 0,
      centerTitle: false,
    ),
  );
}
