import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SeasonLinkPage extends Page<SeasonLinkPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  SeasonLinkPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SeasonLinkPageState>(
              adapter: null, slots: <String, Dependent<SeasonLinkPageState>>{}),
          middleware: <Middleware<SeasonLinkPageState>>[],
        );
}
