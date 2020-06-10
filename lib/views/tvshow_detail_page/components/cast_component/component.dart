import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CastComponent extends Component<CastState> {
  CastComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          shouldUpdate: (oldState, newState) {
            return oldState.casts != newState.casts;
          },
          view: buildView,
          dependencies: Dependencies<CastState>(
              adapter: null, slots: <String, Dependent<CastState>>{}),
        );
}
