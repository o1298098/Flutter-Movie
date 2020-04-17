import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class StreamLinkComponent extends Component<StreamLinkState> {
  StreamLinkComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          shouldUpdate: (oldState, newState) {
            return oldState.episodeNumber != newState.episodeNumber ||
                oldState.episodelistController !=
                    newState.episodelistController ||
                oldState.streamLinks != newState.streamLinks;
          },
          view: buildView,
          dependencies: Dependencies<StreamLinkState>(
              adapter: null, slots: <String, Dependent<StreamLinkState>>{}),
        );
}
