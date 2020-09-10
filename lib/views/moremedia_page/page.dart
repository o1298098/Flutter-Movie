import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MoreMediaPage extends Page<MoreMediaPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  MoreMediaPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MoreMediaPageState>(
              adapter: null, slots: <String, Dependent<MoreMediaPageState>>{}),
          middleware: <Middleware<MoreMediaPageState>>[],
        );
}
