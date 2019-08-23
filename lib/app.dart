import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart' hide Action;

import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/views/episodedetail_page/page.dart';
import 'package:movie/views/favorites_page/page.dart';
import 'package:movie/views/gallery_page/page.dart';
import 'package:movie/views/listdetail_page/page.dart';
import 'package:movie/views/login_page/page.dart';
import 'package:movie/views/main_page/page.dart';
import 'package:movie/views/moviedetail_page/page.dart';
import 'package:movie/views/mylists_page/page.dart';
import 'package:movie/views/peopledetail_page/page.dart';
import 'package:movie/views/search_page/page.dart';
import 'package:movie/views/seasondetail_page/page.dart';
import 'package:movie/views/seasons_page/page.dart';
import 'package:movie/views/tvdetail_page/page.dart';
import 'package:movie/views/watchlist_page/page.dart';
import 'package:movie/views/watchlistdetail_page/page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'actions/timeline.dart';
import 'generated/i18n.dart';
import 'globalbasestate/state.dart';
import 'globalbasestate/store.dart';
import 'views/moremedia_page/page.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:movie/views/detail_page/page.dart' as detail;

Future _init() async {
  if (Platform.isAndroid)
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.contacts]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var session = prefs.getString('loginsession');
  String accessToken = prefs.getString('accessTokenV4');
  if (session == null) {
    await ApiHelper.createGuestSession();
  } else {
    ApiHelper.session = session;
  }
  if (accessToken != null) ApiHelper.accessTokenV4 = accessToken;
  setLocaleInfo('zh', TimelineInfoCN());
  setLocaleInfo('en', TimelineInfoEN());
  setLocaleInfo('Ja', TimelineInfoJA());
}

Future<Widget> createApp() async {
  final AbstractRoutes routes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      'mainpage': MainPage(),
      'loginpage': LoginPage(),
      'moviedetailpage': MovieDetailPage(),
      'tvdetailpage': TVDetailPage(),
      'searchpage': SearchPage(),
      'peopledetailpage': PeopleDetailPage(),
      'seasondetailpage': SeasonDetailPage(),
      'episodedetailpage': EpisodeDetailPage(),
      'MoreMediaPage': MoreMediaPage(),
      'SeasonsPage': SeasonsPage(),
      'MyListsPage': MyListsPage(),
      'ListDetailPage': ListDetailPage(),
      'FavoritesPage': FavoritesPage(),
      'WatchlistPage': WatchlistPage(),
      'WatchlistDetailPage': WatchlistDetailPage(),
      'detailpage': detail.MovieDetailPage(),
      'GalleryPage': GalleryPage()
    },
    visitor: (String path, Page<Object, dynamic> page) {
      if (page.isTypeof<GlobalBaseState>()) {
        page.connectExtraStore<GlobalState>(
          GlobalStore.store,
          (Object pagestate, GlobalState appState) {
            final GlobalBaseState p = pagestate;
            if (p.themeColor != appState.themeColor) {
              if (pagestate is Cloneable) {
                final Object copy = pagestate.clone();
                final GlobalBaseState newState = copy;
                newState.themeColor = appState.themeColor;
                return newState;
              }
            }
            return pagestate;
          },
        );
      }
      page.enhancer.append(
        /// View AOP
        viewMiddleware: <ViewMiddleware<dynamic>>[
          safetyView<dynamic>(),
        ],

        /// Adapter AOP
        adapterMiddleware: <AdapterMiddleware<dynamic>>[
          safetyAdapter<dynamic>()
        ],

        /// Effect AOP
        effectMiddleware: [
          _pageAnalyticsMiddleware<dynamic>(),
        ],

        /// Store AOP
        middleware: <Middleware<dynamic>>[
          logMiddleware<dynamic>(tag: page.runtimeType.toString()),
        ],
      );
    },
  );

  await _init();
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
    localeResolutionCallback:
        I18n.delegate.resolution(fallback: new Locale("en", "US")),
    home: routes.buildPage('mainpage', null),
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}

EffectMiddleware<T> _pageAnalyticsMiddleware<T>({String tag = 'redux'}) {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          print('${logic.runtimeType} ${action.type.toString()} ');
        }
        return effect?.call(action, ctx);
      };
    };
  };
}
