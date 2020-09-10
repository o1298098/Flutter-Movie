import 'package:fish_redux/fish_redux.dart';

import 'adpater/adapter.dart';
import 'components/filter_component/component.dart';
import 'components/filter_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TrendingPage extends Page<TrendingPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  TrendingPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TrendingPageState>(
              adapter: NoneConn<TrendingPageState>() + TrendingAdapter(),
              slots: <String, Dependent<TrendingPageState>>{
                'filter': FilterConnector() + FilterComponent()
              }),
          middleware: <Middleware<TrendingPageState>>[],
        );
}
