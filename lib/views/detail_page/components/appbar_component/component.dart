import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AppBarComponent extends Component<AppBarState> {
  AppBarComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.title != newState.title ||
                oldState.scrollController != newState.scrollController;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AppBarState>(
              adapter: null, slots: <String, Dependent<AppBarState>>{}),
        );
}
