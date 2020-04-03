import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TrailerComponent extends Component<TrailerState> {
  TrailerComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          shouldUpdate: (oldState, newState) {
            return oldState.videos != newState.videos;
          },
          view: buildView,
          dependencies: Dependencies<TrailerState>(
              adapter: null, slots: <String, Dependent<TrailerState>>{}),
        );
}
