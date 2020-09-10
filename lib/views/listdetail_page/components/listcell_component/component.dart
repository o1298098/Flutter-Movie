import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ListCellComponent extends Component<ListCellState> {
  ListCellComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.cellData != newState.cellData;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ListCellState>(
              adapter: null, slots: <String, Dependent<ListCellState>>{}),
        );
}
