import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MainPage extends Page<MainPageState, Map<String, dynamic>> {
  MainPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          shouldUpdate: (oldState, newState) {
            return oldState.locale != newState.locale ||
                oldState.selectedIndex != newState.selectedIndex;
          },
          dependencies: Dependencies<MainPageState>(
              adapter: null, slots: <String, Dependent<MainPageState>>{}),
          middleware: <Middleware<MainPageState>>[],
        );
}
