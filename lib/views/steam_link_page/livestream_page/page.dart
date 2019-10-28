import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LiveStreamPage extends Page<LiveStreamPageState, Map<String, dynamic>> {
  LiveStreamPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<LiveStreamPageState>(
              adapter: null, slots: <String, Dependent<LiveStreamPageState>>{}),
          middleware: <Middleware<LiveStreamPageState>>[],
        );
}
