import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CreateListPage extends Page<CreateListPageState, Map<String, dynamic>> {
  CreateListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<CreateListPageState>(
              adapter: null, slots: <String, Dependent<CreateListPageState>>{}),
          middleware: <Middleware<CreateListPageState>>[],
        );
}
