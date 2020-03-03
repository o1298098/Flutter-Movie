import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class HeaderComponent extends Component<HeaderState> {
  HeaderComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.tvid != newState.tvid ||
                oldState.animationController != newState.animationController ||
                oldState.backdropPic != newState.backdropPic ||
                oldState.mainColor != newState.mainColor ||
                oldState.name != newState.name ||
                oldState.posterPic != newState.posterPic ||
                oldState.tvDetailModel != newState.tvDetailModel;
          },
          clearOnDependenciesChanged: true,
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<HeaderState>(
              adapter: null, slots: <String, Dependent<HeaderState>>{}),
        );
}
