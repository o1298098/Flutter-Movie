import 'package:fish_redux/fish_redux.dart';
import 'components/episodes_component/component.dart';
import 'components/episodes_component/state.dart';
import 'components/header_component/component.dart';
import 'components/header_component/state.dart';
import 'components/seasoncast_component/component.dart';
import 'components/seasoncast_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SeasonDetailPage
    extends Page<SeasonDetailPageState, Map<String, dynamic>> {
  SeasonDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SeasonDetailPageState>(
              slots: <String, Dependent<SeasonDetailPageState>>{
                'header': HeaderConnector() + HeaderComponent(),
                'seasonCast': SeasonCastConnector() + SeasonCastComponent(),
                'episode': EpisodesConnector() + EpisodesComponent(),
              }),
          middleware: <Middleware<SeasonDetailPageState>>[],
        );
}
