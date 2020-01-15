import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class HeaderComponent extends Component<HeaderState> {
  HeaderComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.movie != newState.tv ||
                oldState.tv != newState.tv ||
                oldState.showHeaderMovie != newState.showHeaderMovie;
          },
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<HeaderState>(
              adapter: null, slots: <String, Dependent<HeaderState>>{}),
        );
}
