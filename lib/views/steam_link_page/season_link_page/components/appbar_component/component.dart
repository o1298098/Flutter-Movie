import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class AppBarComponent extends Component<AppBarState> {
  AppBarComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.animationController !=
                    newState.animationController ||
                oldState.backdropPath != newState.backdropPath;
          },
          clearOnDependenciesChanged: true,
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<AppBarState>(
              adapter: null, slots: <String, Dependent<AppBarState>>{}),
        );
}
