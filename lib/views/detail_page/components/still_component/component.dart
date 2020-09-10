import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class StillComponent extends Component<StillState> {
  StillComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.imagesmodel != newState.imagesmodel;
          },
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<StillState>(
              adapter: null, slots: <String, Dependent<StillState>>{}),
        );
}
