import 'package:flutter/material.dart';

class ThemeStyle {
  static final lightTheme = ThemeData.light().copyWith(
    tabBarTheme: TabBarTheme(labelColor: const Color(0xFF000000)),
    backgroundColor: const Color(0xFFFFFFFF),
    cardColor: const Color(0xFFFFFFFF),
    bottomAppBarColor: const Color.fromRGBO(45, 45, 48, 1),
    primaryColorLight: const Color(0xFFF5F5F5),
    primaryColorDark: const Color(0xFFEEEEEE),
  );
  static final darkTheme = ThemeData.dark().copyWith(
      tabBarTheme: TabBarTheme(labelColor: const Color(0xFFFFFFFF)),
      backgroundColor: const Color(0xFF303030),
      bottomAppBarColor: const Color(0xFF191919),
      cardColor: const Color(0xFF333333),
      primaryColorLight: const Color(0xFF505050),
      primaryColorDark: const Color(0xFF404040));
  static MediaQueryData _mediaQuery;
  static ThemeData theme;
  static ThemeData getTheme(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    theme = _mediaQuery.platformBrightness == Brightness.light
        ? lightTheme
        : darkTheme;
    return theme;
  }
}
