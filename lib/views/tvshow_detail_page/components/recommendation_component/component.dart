import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class RecommendationComponent extends Component<RecommendationState> {
  RecommendationComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          shouldUpdate: (oldState, newState) {
            return oldState.data != newState.data;
          },
          view: buildView,
          dependencies: Dependencies<RecommendationState>(
              adapter: null, slots: <String, Dependent<RecommendationState>>{}),
        );
}
