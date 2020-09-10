import 'package:fish_redux/fish_redux.dart';

import 'adapter.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class EpisodeListComponent extends Component<EpisodeListState> {
  EpisodeListComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.episodes != newState.episodes ||
                oldState.season != newState.season ||
                oldState.season.playStates != newState.season.playStates;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<EpisodeListState>(
              adapter: NoneConn<EpisodeListState>() + EpisodeListAdapter(),
              slots: <String, Dependent<EpisodeListState>>{}),
        );
}
