import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TrendingPage extends Page<TrendingPageState, Map<String, dynamic>>
    with SingleTickerProviderMixin {
  TrendingPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TrendingPageState>(
              adapter: null, slots: <String, Dependent<TrendingPageState>>{}),
          middleware: <Middleware<TrendingPageState>>[],
        );
}
