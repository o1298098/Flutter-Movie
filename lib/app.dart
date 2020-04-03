import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart' hide Action;

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie/routes/routes.dart';
import 'actions/timeline.dart';
import 'generated/i18n.dart';
import 'package:permission_handler/permission_handler.dart';

Future _init() async {
  if (Platform.isAndroid)
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  setLocaleInfo('zh', TimelineInfoCN());
  setLocaleInfo('en', TimelineInfoEN());
  setLocaleInfo('Ja', TimelineInfoJA());
}

Future<Widget> createApp() async {
  final AbstractRoutes routes = Routes.routes;
  final ThemeData _lightTheme = ThemeData.light();
  final ThemeData _darkTheme = ThemeData.dark();
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  await _init();

  return MaterialApp(
    title: 'Movie',
    debugShowCheckedModeBanner: false,
    theme: _lightTheme,
    darkTheme: _darkTheme,
    localizationsDelegates: [
      I18n.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: I18n.delegate.supportedLocales,
    localeResolutionCallback:
        I18n.delegate.resolution(fallback: new Locale("en", "US")),
    navigatorObservers: [
      FirebaseAnalyticsObserver(analytics: analytics),
    ],
    home: routes.buildPage('startpage', null),
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}
