import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TrendingCellComponent extends Component<TrendingCellState> {
  TrendingCellComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.index != newState.index ||
                oldState.cellData != newState.cellData ||
                oldState.liked != newState.liked;
          },
          clearOnDependenciesChanged: true,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TrendingCellState>(
              adapter: null, slots: <String, Dependent<TrendingCellState>>{}),
        );
}
