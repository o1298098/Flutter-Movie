import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class RecommendationComponent extends Component<RecommendationState> {
  RecommendationComponent()
      : super(
          effect: buildEffect(),
          view: buildView,
          shouldUpdate: (oldState, newState) {
            return oldState.recommendations != newState.recommendations;
          },
          dependencies: Dependencies<RecommendationState>(
              adapter: null, slots: <String, Dependent<RecommendationState>>{}),
        );
}
