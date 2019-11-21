import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TvShowLiveStreamPage
    extends Page<TvShowLiveStreamPageState, Map<String, dynamic>> {
  TvShowLiveStreamPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TvShowLiveStreamPageState>(
              adapter: null,
              slots: <String, Dependent<TvShowLiveStreamPageState>>{}),
          middleware: <Middleware<TvShowLiveStreamPageState>>[],
        );
}
