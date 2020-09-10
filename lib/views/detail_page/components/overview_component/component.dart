import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class OverViewComponent extends Component<OverViewState> {
  OverViewComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.overView != newState.overView;
          },
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<OverViewState>(
              adapter: null, slots: <String, Dependent<OverViewState>>{}),
        );
}
