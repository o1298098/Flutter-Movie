import 'package:fish_redux/fish_redux.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/views/account_page/page.dart';
import 'package:movie/views/checkout_page/page.dart';
import 'package:movie/views/coming_page/page.dart';
import 'package:movie/views/createlist_page/page.dart';
import 'package:movie/views/discover_page/page.dart';
import 'package:movie/views/episodedetail_page/page.dart';
import 'package:movie/views/favorites_page/page.dart';
import 'package:movie/views/gallery_page/page.dart';
import 'package:movie/views/home_page/page.dart';
import 'package:movie/views/listdetail_page/page.dart';
import 'package:movie/views/login_page/page.dart';
import 'package:movie/views/main_page/page.dart';
import 'package:movie/views/moremedia_page/page.dart';
import 'package:movie/views/moviedetail_page/page.dart';
import 'package:movie/views/mylists_page/page.dart';
import 'package:movie/views/payment_page/page.dart';
import 'package:movie/views/peopledetail_page/page.dart';
import 'package:movie/views/premium_page/page.dart';
import 'package:movie/views/register_page/page.dart';
import 'package:movie/views/seasondetail_page/page.dart';
import 'package:movie/views/seasons_page/page.dart';
import 'package:movie/views/setting_page/page.dart';
import 'package:movie/views/start_page/page.dart';
import 'package:movie/views/steam_link_page/addlink_page/page.dart';
import 'package:movie/views/steam_link_page/allstreamlink_page/page.dart';
import 'package:movie/views/steam_link_page/livestream_page/page.dart';
import 'package:movie/views/steam_link_page/season_link_page/page.dart';
import 'package:movie/views/steam_link_page/steamlinks_page/page.dart';
import 'package:movie/views/steam_link_page/tvshow_livestream_page/page.dart';
import 'package:movie/views/test_page/page.dart';
import 'package:movie/views/tvdetail_page/page.dart';
import 'package:movie/views/watchlist_page/page.dart';
import 'package:movie/views/watchlistdetail_page/page.dart';

import 'package:movie/views/detail_page/page.dart' as detail;

class Routes {
  static final PageRoutes routes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      'startpage': StartPage(),
      'mainpage': MainPage(),
      'homePage': HomePage(),
      'discoverPage': DiscoverPage(),
      'comingPage': ComingPage(),
      'accountPage': AccountPage(),
      'loginpage': LoginPage(),
      'moviedetailpage': MovieDetailPage(),
      'tvdetailpage': TVDetailPage(),
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
      'GalleryPage': GalleryPage(),
      'streamLinksPage': StreamLinksPage(),
      'addLinkPage': AddLinkPage(),
      'registerPage': RegisterPage(),
      'createListPage': CreateListPage(),
      'allStreamLinkPage': AllStreamLinkPage(),
      'liveStreamPage': LiveStreamPage(),
      'tvShowLiveStreamPage': TvShowLiveStreamPage(),
      'seasonLinkPage': SeasonLinkPage(),
      'testPage': TestPage(),
      'settingPage': SettingPage(),
      'paymentPage': PaymentPage(),
      'premiumPage': PremiumPage(),
      'checkoutPage': CheckOutPage(),
    },
    visitor: (String path, Page<Object, dynamic> page) {
      if (page.isTypeof<GlobalBaseState>()) {
        page.connectExtraStore<GlobalState>(GlobalStore.store,
            (Object pagestate, GlobalState appState) {
          final GlobalBaseState p = pagestate;
          if (p.themeColor != appState.themeColor ||
              p.locale != appState.locale ||
              p.user != appState.user) {
            if (pagestate is Cloneable) {
              final Object copy = pagestate.clone();
              final GlobalBaseState newState = copy;
              newState.themeColor = appState.themeColor;
              newState.locale = appState.locale;
              newState.user = appState.user;
              return newState;
            }
          }
          return pagestate;
        });
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
