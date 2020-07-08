import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PlayerComponent extends Component<PlayerState> {
  PlayerComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          shouldUpdate: (oldState, newState) {
            return oldState.chewieController != newState.chewieController ||
                oldState.youtubePlayerController !=
                    newState.youtubePlayerController ||
                oldState.streamAddress != newState.streamAddress ||
                oldState.streamLinkTypeName != newState.streamLinkTypeName;
          },
          view: buildView,
          dependencies: Dependencies<PlayerState>(
              adapter: null, slots: <String, Dependent<PlayerState>>{}),
        );
}
