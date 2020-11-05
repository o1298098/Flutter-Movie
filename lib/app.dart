import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart' hide Action;

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie/routes/routes.dart';
import 'actions/app_config.dart';
import 'actions/api/tmdb_api.dart';
import 'actions/timeline.dart';
import 'actions/user_info_operate.dart';
import 'generated/i18n.dart';
import 'package:permission_handler/permission_handler.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final i18n = I18n.delegate;

  final AbstractRoutes routes = Routes.routes;
  final ThemeData _lightTheme =
      ThemeData.light().copyWith(accentColor: Colors.transparent);
  final ThemeData _darkTheme =
      ThemeData.dark().copyWith(accentColor: Colors.transparent);
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  Future _init() async {
    if (Platform.isAndroid)
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    setLocaleInfo('zh', TimelineInfoCN());
    setLocaleInfo('en', TimelineInfoEN());
    setLocaleInfo('Ja', TimelineInfoJA());

    await AppConfig.instance.init(context);

    await TMDBApi.instance.init();

    await UserInfoOperate.whenAppStart();
  }

  @override
  void initState() {
    I18n.onLocaleChanged = onLocaleChange;

    _init();
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
}
