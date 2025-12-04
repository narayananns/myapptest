import 'package:flutter/material.dart';

class AppTheme {
  // ---------------------- DARK THEME ----------------------
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: const Color(0xFF0EA5E9),

    cardColor: const Color(0xFF1E1E1E),

    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF0EA5E9),
      onPrimary: Colors.black,
      secondary: Color(0xFF0EA5E9),
      onSecondary: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
      background: Color(0xFF121212),
      onBackground: Colors.white,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white70,
    ),

    iconTheme: const IconThemeData(color: Colors.white),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: true,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF1E1E1E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintStyle: const TextStyle(color: Colors.white54),
      labelStyle: const TextStyle(color: Colors.white70),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0EA5E9),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),

    chipTheme: const ChipThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedColor: Color(0xFF0EA5E9),
      disabledColor: Colors.grey,
      secondaryLabelStyle: TextStyle(color: Colors.white),
      labelStyle: TextStyle(color: Colors.white),
      secondarySelectedColor: Color(0xFF0EA5E9),
    ),
  );

  // ---------------------- LIGHT THEME ----------------------
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xFF0EA5E9),

    cardColor: Colors.white,

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
      surface: Color(0xFFFFFFFF),
      onSurface: Colors.black54,
    ),

    iconTheme: const IconThemeData(color: Colors.black),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      centerTitle: true,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFF5F6F8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintStyle: const TextStyle(color: Colors.black45),
      labelStyle: const TextStyle(color: Colors.black87),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0EA5E9),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),

    chipTheme: const ChipThemeData(
      backgroundColor: Color(0xFFF5F6F8),
      selectedColor: Color(0xFF0EA5E9),
      disabledColor: Colors.grey,
      secondaryLabelStyle: TextStyle(color: Colors.black),
      labelStyle: TextStyle(color: Colors.black),
      secondarySelectedColor: Color(0xFF0EA5E9),
    ),
  );
}
