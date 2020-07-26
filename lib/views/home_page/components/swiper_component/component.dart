import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class SwiperComponent extends Component<SwiperState> {
  SwiperComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.movie != newState.movie ||
                oldState.tv != newState.tv ||
                oldState.showHeaderMovie != newState.showHeaderMovie;
          },
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<SwiperState>(
              adapter: null, slots: <String, Dependent<SwiperState>>{}),
        );
}
