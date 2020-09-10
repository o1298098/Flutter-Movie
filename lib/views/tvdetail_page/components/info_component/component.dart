import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class InfoComponent extends Component<InfoState> {
  InfoComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.tvDetailModel != newState.tvDetailModel;
          },
          clearOnDependenciesChanged: true,
          view: buildView,
          effect: buildEffect(),
          dependencies: Dependencies<InfoState>(
              adapter: null, slots: <String, Dependent<InfoState>>{}),
        );
}
