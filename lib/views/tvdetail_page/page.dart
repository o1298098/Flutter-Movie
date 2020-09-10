import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/tvdetail_page/components/featuredcrew_component/component.dart';
import 'package:movie/views/tvdetail_page/components/info_component/component.dart';
import 'package:movie/views/tvdetail_page/components/menu_component/component.dart';

import 'components/Images_component/component.dart';
import 'components/Images_component/state.dart';
import 'components/currentseason_component/component.dart';
import 'components/currentseason_component/state.dart';
import 'components/featuredcrew_component/state.dart';
import 'components/header_component/component.dart';
import 'components/header_component/state.dart';
import 'components/info_component/state.dart';
import 'components/keywords_component/component.dart';
import 'components/keywords_component/state.dart';
import 'components/menu_component/state.dart';
import 'components/recommendation_component/component.dart';
import 'components/recommendation_component/state.dart';
import 'components/review_component/component.dart';
import 'components/review_component/state.dart';
import 'components/video_component/component.dart';
import 'components/video_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TVDetailPage extends Page<TVDetailPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  TVDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TVDetailPageState>(
              adapter: null,
              slots: <String, Dependent<TVDetailPageState>>{
                'header': HeaderConnector() + HeaderComponent(),
                'keywords': KeyWordsConnector() + KeyWordsComponent(),
                'tvInfo': TvInfoConnector() + TvInfoComponent(),
                'currentSeason':
                    CurrentSeasonConnector() + CurrentSeasonComponent(),
                'recommendations':
                    RecommendationConnector() + RecommendationComponent(),
                'info': InfoConnector() + InfoComponent(),
                'menu': MenuConnector() + MenuComponent(),
                'videos': VideoConnector() + VideoComponent(),
                'images': ImagesConnector() + ImagesComponent(),
                'reviews': ReviewConnector() + ReviewComponent(),
              }),
          middleware: <Middleware<TVDetailPageState>>[],
        );
}
