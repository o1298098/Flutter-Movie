import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class InfoGroupComponent extends Component<InfoGroupState> {
  InfoGroupComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.itemCount != newState.itemCount ||
                oldState.rating != newState.rating ||
                oldState.revenue != newState.revenue ||
                oldState.runTime != newState.runTime;
          },
          view: buildView,
          dependencies: Dependencies<InfoGroupState>(
              adapter: null, slots: <String, Dependent<InfoGroupState>>{}),
        );
}
