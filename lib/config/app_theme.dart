import 'package:flutter/material.dart';

class AppTheme {
  // ---------------------- DARK THEME ----------------------
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color(0xFF1C1C1E),
    primaryColor: const Color(0xFF0EA5E9),

    cardColor: const Color(0xFF2A2A2E),

    // FULL COLOR SCHEME (required fields included)
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF0EA5E9),
      onPrimary: Colors.black,
      secondary: Color(0xFF0EA5E9),
      onSecondary: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
      background: Color(0xFF1C1C1E),
      onBackground: Colors.white,
      surface: Color(0xFF2A2A2E),
      onSurface: Colors.white,   // THIS fixes text visibility on cards
    ),

    iconTheme: const IconThemeData(color: Colors.white),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1C1C1E),
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF2C2C2E),
      selectedItemColor: Color(0xFF0EA5E9),
      unselectedItemColor: Colors.white60,
    ),
  );

  // ---------------------- LIGHT THEME ----------------------
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xFF0EA5E9),

    cardColor: Colors.white,

    // FULL COLOR SCHEME (required fields included)
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF0EA5E9),
      onPrimary: Colors.white,
      secondary: Color(0xFF0EA5E9),
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black87, // TEXT visible on cards
    ),

    iconTheme: const IconThemeData(color: Colors.black),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF0EA5E9),
      unselectedItemColor: Colors.grey,
    ),
  );
}
