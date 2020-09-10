import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SeasonsPage extends Page<SeasonsPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  SeasonsPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SeasonsPageState>(
              adapter: null, slots: <String, Dependent<SeasonsPageState>>{}),
          middleware: <Middleware<SeasonsPageState>>[],
        );
}
