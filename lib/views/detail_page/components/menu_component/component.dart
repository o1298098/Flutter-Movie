import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MenuComponent extends Component<MenuState> {
  MenuComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.accountState != newState.accountState ||
                oldState.backdropPic != newState.backdropPic ||
                oldState.detail != newState.detail;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MenuState>(
              adapter: null, slots: <String, Dependent<MenuState>>{}),
        );
}
