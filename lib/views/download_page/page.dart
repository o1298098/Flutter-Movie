import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DownloadPage extends Page<DownloadPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  DownloadPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DownloadPageState>(
              adapter: null, slots: <String, Dependent<DownloadPageState>>{}),
          middleware: <Middleware<DownloadPageState>>[],
        );
}
