import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SeasonCastComponent extends Component<SeasonCastState> {
  SeasonCastComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.castData != newState.castData;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SeasonCastState>(
              adapter: null, slots: <String, Dependent<SeasonCastState>>{}),
        );
}
