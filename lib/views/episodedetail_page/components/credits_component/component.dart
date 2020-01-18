import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class CreditsComponent extends Component<CreditsState> {
  CreditsComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.crew != newState.crew ||
                oldState.guestStars != newState.guestStars;
          },
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<CreditsState>(
              adapter: null, slots: <String, Dependent<CreditsState>>{}),
        );
}
