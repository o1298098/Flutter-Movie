import 'package:fish_redux/fish_redux.dart';

import 'components/appbar_component/component.dart';
import 'components/appbar_component/state.dart';
import 'components/cast_component/component.dart';
import 'components/cast_component/state.dart';
import 'components/keyword_component/component.dart';
import 'components/keyword_component/state.dart';
import 'components/maininfo_component/component.dart';
import 'components/maininfo_component/state.dart';
import 'components/menu_component/component.dart';
import 'components/menu_component/state.dart';
import 'components/overview_component/component.dart';
import 'components/overview_component/state.dart';
import 'components/recommendation_component/component.dart';
import 'components/recommendation_component/state.dart';
import 'components/still_component/component.dart';
import 'components/still_component/state.dart';
import 'components/trailer_component/component.dart';
import 'components/trailer_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MovieDetailPage extends Page<MovieDetailPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  MovieDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          shouldUpdate: (o, n) {
            return false;
          },
          view: buildView,
          dependencies: Dependencies<MovieDetailPageState>(
              adapter: null,
              slots: <String, Dependent<MovieDetailPageState>>{
                'appbar': AppBarConnector() + AppBarComponent(),
                'mainInfo': MainInfoConnector() + MainInfoComponent(),
                'menu': MenuConnector() + MenuComponent(),
                'overView': OverViewConnector() + OverViewComponent(),
                'cast': CastConnector() + CastComponent(),
                'still': StillConnector() + StillComponent(),
                'keyWords': KeyWordConnector() + KeyWordComponent(),
                'trailer': TrailerConnector() + TrailerComponent(),
                'recommendations':
                    RecommendationsConnector() + RecommendationsComponent(),
              }),
          middleware: <Middleware<MovieDetailPageState>>[],
        );
}
