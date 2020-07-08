import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AllStreamLinkPage
    extends Page<AllStreamLinkPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  AllStreamLinkPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AllStreamLinkPageState>(
              adapter: null,
              slots: <String, Dependent<AllStreamLinkPageState>>{}),
          middleware: <Middleware<AllStreamLinkPageState>>[],
        );
}
