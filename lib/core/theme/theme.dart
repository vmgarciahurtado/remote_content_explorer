import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() => _build(
    brightness: Brightness.light,
    bg: Colors.white,
    primary: Colors.black,
    secondary: Colors.black,
    appBarBg: Colors.white,
    appBarFg: Colors.black,
  );

  static ThemeData dark() => _build(
    brightness: Brightness.dark,
    bg: Color(0xFF1A1A1A),
    primary: Colors.white,
    secondary: Colors.white,
    appBarBg: Color(0xFF121212),
    appBarFg: Colors.white,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color bg,
    required Color primary,
    required Color secondary,
    required Color appBarBg,
    required Color appBarFg,
  }) => ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
      brightness: brightness,
      surface: bg,
    ),
    scaffoldBackgroundColor: bg,
    textTheme: _textTheme(primary, secondary),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: appBarBg,
      foregroundColor: appBarFg,
    ),
    cardColor: brightness == Brightness.light
        ? Colors.white
        : const Color(0xFF2C2C2C),
    cardTheme: CardThemeData(
      color: brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF2C2C2C),
      elevation: 0,
      margin: EdgeInsets.zero,
    ),
  );

  static TextTheme _textTheme(Color primary, Color secondary) => TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 32,
      color: primary,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: secondary,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: secondary,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: secondary,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: secondary,
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: secondary,
    ),
  );
}
