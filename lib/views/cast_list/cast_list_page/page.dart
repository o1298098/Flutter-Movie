import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CastListPage extends Page<CastListState, Map<String, dynamic>> {
  CastListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<CastListState>(
              adapter: null, slots: <String, Dependent<CastListState>>{}),
          middleware: <Middleware<CastListState>>[],
        );
}
