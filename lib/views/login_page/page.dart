import 'package:fish_redux/fish_redux.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LoginPage extends Page<LoginPageState, Map<String, dynamic>> {
  @override
  CustomstfState<LoginPageState> createState() =>
      CustomstfState<LoginPageState>();

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
