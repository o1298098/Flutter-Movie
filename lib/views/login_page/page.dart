import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LoginPage extends Page<LoginPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  LoginPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<LoginPageState>(
              adapter: null, slots: <String, Dependent<LoginPageState>>{}),
          middleware: <Middleware<LoginPageState>>[],
        );
}
