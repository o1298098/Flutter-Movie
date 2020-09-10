import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MainInfoComponent extends Component<MainInfoState> {
  MainInfoComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.bgPic != newState.bgPic ||
                oldState.detail != newState.detail ||
                oldState.hasStreamLink != newState.hasStreamLink ||
                oldState.scrollController != newState.scrollController;
          },
          clearOnDependenciesChanged: true,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MainInfoState>(
              adapter: null, slots: <String, Dependent<MainInfoState>>{}),
        );
}
