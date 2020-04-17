import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TabComponent extends Component<TabState> {
  TabComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.showMovie != newState.showMovie;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TabState>(
              adapter: null, slots: <String, Dependent<TabState>>{}),
        );
}
