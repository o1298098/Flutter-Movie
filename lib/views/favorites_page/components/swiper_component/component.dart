import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SwiperComponent extends Component<SwiperState> {
  SwiperComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.animationController !=
                    newState.animationController ||
                oldState.isMovie != newState.isMovie ||
                oldState.movies != newState.movies ||
                oldState.tvshows != newState.tvshows;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SwiperState>(
              adapter: null, slots: <String, Dependent<SwiperState>>{}),
        );
}
