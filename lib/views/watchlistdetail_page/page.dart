import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class WatchlistDetailPage
    extends Page<WatchlistDetailPageState, Map<String, dynamic>>
    with SingleTickerProviderMixin {
  WatchlistDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<WatchlistDetailPageState>(
              adapter: null,
              slots: <String, Dependent<WatchlistDetailPageState>>{}),
          middleware: <Middleware<WatchlistDetailPageState>>[],
        );
}
