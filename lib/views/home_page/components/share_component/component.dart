import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
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
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<ShareState>(
              adapter: null, slots: <String, Dependent<ShareState>>{}),
        );
}
