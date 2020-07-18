import 'package:fish_redux/fish_redux.dart';

import 'components/bottom_panel_component/component.dart';
import 'components/bottom_panel_component/state.dart';
import 'components/header_component/component.dart';
import 'components/header_component/state.dart';
import 'components/player_component/component.dart';
import 'components/player_component/state.dart';
import 'components/recommendation_component/component.dart';
import 'components/recommendation_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MovieLiveStreamPage
    extends Page<MovieLiveStreamState, Map<String, dynamic>> {
  MovieLiveStreamPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          shouldUpdate: (o, n) {
            return o.detail != n.detail || o.movieId != n.movieId;
          },
          dependencies: Dependencies<MovieLiveStreamState>(
              adapter: null,
              slots: <String, Dependent<MovieLiveStreamState>>{
                'player': PlayerConnector() + PlayerComponent(),
                'header': HeaderConnector() + HeaderComponent(),
                'recommendation':
                    RecommendationConnector() + RecommendationComponent(),
                'bottomPanel': BottomPanelConnector() + BottomPanelComponent(),
              }),
          middleware: <Middleware<MovieLiveStreamState>>[],
        );
}
