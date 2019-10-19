import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FirebaseLoginPage
    extends Page<FirebaseLoginPageState, Map<String, dynamic>> {
  FirebaseLoginPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<FirebaseLoginPageState>(
              adapter: null,
              slots: <String, Dependent<FirebaseLoginPageState>>{}),
          middleware: <Middleware<FirebaseLoginPageState>>[],
        );
}
