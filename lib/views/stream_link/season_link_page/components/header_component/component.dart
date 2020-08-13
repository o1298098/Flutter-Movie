import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class HeaderComponent extends Component<HeaderState> {
  HeaderComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.name != newState.name ||
                oldState.genres != newState.genres ||
                oldState.posterPath != newState.posterPath ||
                oldState.overview != newState.overview;
          },
          clearOnDependenciesChanged: true,
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<HeaderState>(
              adapter: null, slots: <String, Dependent<HeaderState>>{}),
        );
}
