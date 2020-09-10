import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class AddCellComponent extends Component<AddCellState> {
  AddCellComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.animationController != newState.animationController;
          },
          view: buildView,
          dependencies: Dependencies<AddCellState>(
              adapter: null, slots: <String, Dependent<AddCellState>>{}),
        );
}
