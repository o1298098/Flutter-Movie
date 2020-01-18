import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ShareComponent extends Component<ShareState> {
  ShareComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.shareMovies != newState.shareMovies ||
                oldState.shareTvshows != newState.shareTvshows ||
                oldState.showShareMovie != newState.showShareMovie;
          },
          clearOnDependenciesChanged: true,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ShareState>(
              adapter: null, slots: <String, Dependent<ShareState>>{}),
        );
}
