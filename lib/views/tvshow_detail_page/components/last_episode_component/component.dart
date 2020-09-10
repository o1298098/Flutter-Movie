import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LastEpisodeComponent extends Component<LastEpisodeState> {
  LastEpisodeComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          shouldUpdate: (oldState, newState) {
            return oldState.lastEpisodeToAir != newState.lastEpisodeToAir;
          },
          view: buildView,
          dependencies: Dependencies<LastEpisodeState>(
              adapter: null, slots: <String, Dependent<LastEpisodeState>>{}),
        );
}
