import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class VideoComponent extends Component<VideoState> {
  VideoComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.videos != newState.videos;
          },
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<VideoState>(
              adapter: null, slots: <String, Dependent<VideoState>>{}),
        );
}
