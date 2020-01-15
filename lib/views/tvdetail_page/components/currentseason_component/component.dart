import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class CurrentSeasonComponent extends Component<CurrentSeasonState> {
  CurrentSeasonComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.lastToAirData != newState.lastToAirData ||
                oldState.name != newState.name ||
                oldState.nextToAirData != newState.nextToAirData ||
                oldState.nowseason != newState.nowseason ||
                oldState.seasons != newState.seasons ||
                oldState.tvid != newState.tvid;
          },
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<CurrentSeasonState>(
              adapter: null, slots: <String, Dependent<CurrentSeasonState>>{}),
        );
}
