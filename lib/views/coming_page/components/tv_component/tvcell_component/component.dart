import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TVCellComponent extends Component<TVCellState> {
  TVCellComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TVCellState>(
              adapter: null, slots: <String, Dependent<TVCellState>>{}),
        );
}
