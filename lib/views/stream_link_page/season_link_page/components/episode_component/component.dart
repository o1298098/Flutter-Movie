import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class EpisodeComponent extends Component<EpisodeState> {
  EpisodeComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.episode != newState.episode ||
                oldState.playState != newState.playState;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<EpisodeState>(
              adapter: null, slots: <String, Dependent<EpisodeState>>{}),
        );
}
