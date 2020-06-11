import 'package:fish_redux/fish_redux.dart';
import 'components/cast_component/component.dart';
import 'components/cast_component/state.dart';
import 'components/keyword_component/component.dart';
import 'components/keyword_component/state.dart';
import 'components/last_episode_component/component.dart';
import 'components/last_episode_component/state.dart';
import 'components/menu_component/component.dart';
import 'components/menu_component/state.dart';
import 'components/recommendation_component/component.dart';
import 'components/recommendation_component/state.dart';
import 'components/season_component/component.dart';
import 'components/season_component/state.dart';
import 'components/swiper_component/component.dart';
import 'components/swiper_component/state.dart';

import 'components/title_component/component.dart';
import 'components/title_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TvShowDetailPage extends Page<TvShowDetailState, Map<String, dynamic>>
    with TickerProviderMixin {
  TvShowDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TvShowDetailState>(
              adapter: null,
              slots: <String, Dependent<TvShowDetailState>>{
                'menu': MenuConnector() + MenuComponent(),
                'swiper': SwiperConnector() + SwiperComponent(),
                'title': TitleConnector() + TitleComponent(),
                'cast': CastConnector() + CastComponent(),
                'lastEpisode': LastEpisodeConnector() + LastEpisodeComponent(),
                'season': SeasonConnector() + SeasonComponent(),
                'keyword': KeywordConnector() + KeywordComponent(),
                'recommendation':
                    RecommendationConnector() + RecommendationComponent(),
              }),
          middleware: <Middleware<TvShowDetailState>>[],
        );
}
