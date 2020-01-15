import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class HeaderComponent extends Component<HeaderState> {
  HeaderComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.bgPic != newState.bgPic ||
                oldState.detail != newState.detail ||
                oldState.hasStreamLink != newState.hasStreamLink ||
                oldState.scrollController != newState.scrollController;
          },
          clearOnDependenciesChanged: true,
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<HeaderState>(
              adapter: null, slots: <String, Dependent<HeaderState>>{}),
        );
}
