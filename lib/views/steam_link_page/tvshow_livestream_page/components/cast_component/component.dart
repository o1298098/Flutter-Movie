import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CastComponent extends Component<CastState> {
  CastComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.credits != newState.credits ||
                oldState.crew != newState.crew ||
                oldState.guestStars != newState.guestStars;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<CastState>(
              adapter: null, slots: <String, Dependent<CastState>>{}),
        );
}
