import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AddLinkPage extends Page<AddLinkPageState, Map<String, dynamic>> {
  AddLinkPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AddLinkPageState>(
              adapter: null, slots: <String, Dependent<AddLinkPageState>>{}),
          middleware: <Middleware<AddLinkPageState>>[],
        );
}
