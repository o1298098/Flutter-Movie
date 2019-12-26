import 'package:flutter/material.dart';

class ThemeStyle {
  static final lightTheme = ThemeData.light().copyWith(
      tabBarTheme: TabBarTheme(labelColor: Colors.black),
      backgroundColor: Colors.white,
      cardColor: Colors.white,
      bottomAppBarColor: Color.fromRGBO(45, 45, 48, 1),
      primaryColorLight: Colors.grey[100],
      primaryColorDark: Colors.grey[200]);
  static final darkTheme = ThemeData.dark().copyWith(
      tabBarTheme: TabBarTheme(labelColor: Colors.white),
      backgroundColor: Color(0xFF303030),
      bottomAppBarColor: Color(0xFF191919),
      cardColor: Color(0xFF333333),
      primaryColorLight: Color(0xFF505050),
      primaryColorDark: Color(0xFF404040));
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
