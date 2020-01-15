import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class TrendingComponent extends Component<TrendingState> {
  TrendingComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.trending != newState.trending;
          },
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<TrendingState>(
              adapter: null, slots: <String, Dependent<TrendingState>>{}),
        );
}
