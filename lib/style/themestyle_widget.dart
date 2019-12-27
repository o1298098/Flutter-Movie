import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/generated/i18n.dart';
import 'themestyle.dart';

class ThemeStyleWidget extends StatefulWidget {
  ThemeStyleWidget({@required this.child, Key key}) : super(key: key);
  final Widget child;
  static _ThemeStyleData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ThemeStyleData>();
  @override
  _ThemeStyleState createState() => _ThemeStyleState();
}

class _ThemeStyleState extends State<ThemeStyleWidget> {
  @override
  void initState() {
    I18n.onLocaleChanged = onLocaleChange;
    super.initState();
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      I18n.locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (c) {
            final MediaQueryData _mediaQuery = MediaQuery.of(c);
            final ThemeData _theme =
                _mediaQuery.platformBrightness == Brightness.light
                    ? ThemeStyle.lightTheme
                    : ThemeStyle.darkTheme;
            return _ThemeStyleData(theme: _theme, child: widget.child);
          },
        ));
  }
}

class _ThemeStyleData extends InheritedWidget {
  _ThemeStyleData({@required this.theme, Widget child}) : super(child: child);
  final ThemeData theme;

  static _ThemeStyleData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_ThemeStyleData>();
  }

  @override
  bool updateShouldNotify(_ThemeStyleData oldWidget) {
    return oldWidget.theme != theme;
  }
}
