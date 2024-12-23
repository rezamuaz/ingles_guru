import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class UXTheme {
  static final String? fontFamily = GoogleFonts.poppins().fontFamily;
  static const barOverLayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );
  static final Color lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color darkFocusColor = Colors.white.withOpacity(0.12);
  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
        colorScheme: colorScheme,
        canvasColor: colorScheme.surface,
        scaffoldBackgroundColor: colorScheme.surface,
        focusColor: focusColor);
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFFFC700),
    onPrimary: Colors.black,
    secondary: Color(0xFFEFF3F3),
    onSecondary: Color(0xFF322942),
    error: Colors.redAccent,
    onError: Colors.white,

    surface: Color(0xFFFAFBFB),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );
  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    secondary: Color(0xFF4D1F7C),
    surface: Color(0xFF1F1929),
    error: Colors.redAccent,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );

  static ThemeData lightTheme = themeData(lightColorScheme, lightFocusColor);
  static ThemeData darkTheme = themeData(darkColorScheme, darkFocusColor);
}