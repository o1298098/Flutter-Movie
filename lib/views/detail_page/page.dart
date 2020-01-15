import 'package:fish_redux/fish_redux.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';

import 'components/cast_component/component.dart';
import 'components/cast_component/state.dart';
import 'components/header_component/component.dart';
import 'components/header_component/state.dart';
import 'components/keyword_component/component.dart';
import 'components/keyword_component/state.dart';
import 'components/menu_component/component.dart';
import 'components/menu_component/state.dart';
import 'components/overview_component/component.dart';
import 'components/overview_component/state.dart';
import 'components/recommendation_component/component.dart';
import 'components/recommendation_component/state.dart';
import 'components/still_component/component.dart';
import 'components/still_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MovieDetailPage extends Page<MovieDetailPageState, Map<String, dynamic>> {
  @override
  CustomstfState<MovieDetailPageState> createState() =>
      CustomstfState<MovieDetailPageState>();
  MovieDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MovieDetailPageState>(
              adapter: null,
              slots: <String, Dependent<MovieDetailPageState>>{
                'menu': MenuConnector() + MenuComponent(),
                'header': HeaderConnector() + HeaderComponent(),
                'overView': OverViewConnector() + OverViewComponent(),
                'cast': CastConnector() + CastComponent(),
                'still': StillConnector() + StillComponent(),
                'keyWords': KeyWordConnector() + KeyWordComponent(),
                'recommendations':
                    RecommendationsConnector() + RecommendationsComponent(),
              }),
          middleware: <Middleware<MovieDetailPageState>>[],
        );
}
