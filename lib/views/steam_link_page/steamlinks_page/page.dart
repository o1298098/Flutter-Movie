import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class StreamLinksPage extends Page<StreamLinksPageState, Map<String, dynamic>> {
  StreamLinksPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<StreamLinksPageState>(
              adapter: null,
              slots: <String, Dependent<StreamLinksPageState>>{}),
          middleware: <Middleware<StreamLinksPageState>>[],
        );
}
