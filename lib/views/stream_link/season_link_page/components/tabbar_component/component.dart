import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class TabbarComponent extends Component<TabbarState> {
  TabbarComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.tabController != newState.tabController ||
                oldState.seasons != newState.seasons;
          },
          clearOnDependenciesChanged: true,
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<TabbarState>(
              adapter: null, slots: <String, Dependent<TabbarState>>{}),
        );
}
