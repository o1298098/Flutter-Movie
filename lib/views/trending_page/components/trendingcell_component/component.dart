import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class TrendingCellComponent extends Component<TrendingCellState> {
  TrendingCellComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.index != newState.index ||
                oldState.cellData != newState.cellData;
          },
          clearOnDependenciesChanged: true,
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<TrendingCellState>(
              adapter: null, slots: <String, Dependent<TrendingCellState>>{}),
        );
}
