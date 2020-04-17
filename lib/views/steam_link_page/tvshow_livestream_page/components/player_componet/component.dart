import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TvPlayerComponent extends Component<TvPlayerState> {
  TvPlayerComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          shouldUpdate: (oldState, newState) {
            return oldState.chewieController != newState.chewieController ||
                oldState.streamAddress != newState.streamAddress ||
                oldState.streamLinkTypeName != newState.streamLinkTypeName ||
                oldState.youtubePlayerController !=
                    newState.youtubePlayerController;
          },
          view: buildView,
          dependencies: Dependencies<TvPlayerState>(
              adapter: null, slots: <String, Dependent<TvPlayerState>>{}),
        );
}
