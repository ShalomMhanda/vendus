import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
    colorScheme: ColorScheme(
        primary: const Color(0xFF14213D),
        onPrimary: const Color(0xFFFFFFFF),
        secondary: const Color(0xFFFCA311),
        onSecondary: const Color(0xFF000000),
        background: const Color(0xFFE5E5E5),
        onBackground: const Color(0xFF14213D),
        surface: Color(0xFFF6F7ED),
        onSurface: Color(0xFF373738),
        error: const Color(0xFFFF0000),
        onError: const Color(0xFFFFFFFF),
        brightness: Brightness.light),
    useMaterial3: true);
