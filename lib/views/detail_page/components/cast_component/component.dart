import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class CastComponent extends Component<CastState> {
  CastComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.cast != newState.cast;
          },
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<CastState>(
              adapter: null, slots: <String, Dependent<CastState>>{}),
        );
}
