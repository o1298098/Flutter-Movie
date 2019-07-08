
import 'package:flutter/material.dart';

import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/views/episodedetail_page/page.dart';
import 'package:movie/views/login_page/page.dart';
import 'package:movie/views/main_page/page.dart';
import 'package:movie/views/moviedetail_page/page.dart';
import 'package:movie/views/peopledetail_page/page.dart';
import 'package:movie/views/seasondetail_page/page.dart';
import 'package:movie/views/tvdetail_page/page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/i18n.dart';
import 'globalbasestate/state.dart';
import 'globalbasestate/store.dart';

//create global page helper
Page<T, dynamic> pageConfiguration<T extends GlobalBaseState<T>>(
    Page<T, dynamic> page) {
  return page

    ///connect with app-store
    ..connectExtraStore(GlobalStore.store, (T pagestate, GlobalState appState) {
      return pagestate.themeColor == appState.themeColor
          ? pagestate
          : ((pagestate.clone())..themeColor = appState.themeColor);
    })

    ///updateMiddleware
    ..updateMiddleware(
      view: (List<ViewMiddleware<T>> viewMiddleware) {
        viewMiddleware.add(safetyView<T>());
      },
      adapter: (List<AdapterMiddleware<T>> adapterMiddleware) {
        adapterMiddleware.add(safetyAdapter<T>());
      },
    );
}

Future getSeesion() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var session = prefs.getString('loginsession');
  if (session == null) {
    await ApiHelper.createGuestSession();
  } else {
    ApiHelper.session = session;
  }
}
Future<Widget> createApp() async {
  final AbstractRoutes routes = HybridRoutes(routes: <AbstractRoutes>[
    PageRoutes(
      pages: <String, Page<Object, dynamic>>{
        'mainpage': pageConfiguration(MainPage()),
        'loginpage': pageConfiguration(LoginPage()),
        'moviedetailpage':pageConfiguration(MovieDetailPage()),
        'tvdetailpage':pageConfiguration(TVDetailPage()),
        'peopledetailpage':pageConfiguration(PeopleDetailPage()),
        'seasondetailpage':pageConfiguration(SeasonDetailPage()),
        'episodedetailpage':pageConfiguration(EpisodeDetailPage()),
      },
    ),
  ]);
  await getSeesion();
  return MaterialApp(
    title: 'Movie',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    localizationsDelegates: [
      I18n.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: I18n.delegate.supportedLocales,
    localeResolutionCallback: I18n.delegate.resolution(fallback: new Locale("en", "US")),
    home: routes.buildPage('mainpage', null),
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}
