import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SettingPage extends Page<SettingPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  SettingPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SettingPageState>(
              adapter: null, slots: <String, Dependent<SettingPageState>>{}),
          middleware: <Middleware<SettingPageState>>[],
        );
}
