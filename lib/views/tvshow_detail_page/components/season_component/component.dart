import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SeasonComponent extends Component<SeasonState> {
  SeasonComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          shouldUpdate: (oldState, newState) {
            return oldState.seasons != newState.seasons;
          },
          view: buildView,
          dependencies: Dependencies<SeasonState>(
              adapter: null, slots: <String, Dependent<SeasonState>>{}),
        );
}
