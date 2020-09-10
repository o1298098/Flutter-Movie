import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class RecommendationsComponent extends Component<RecommendationsState> {
  RecommendationsComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.recommendations != newState.recommendations;
          },
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<RecommendationsState>(
              adapter: null,
              slots: <String, Dependent<RecommendationsState>>{}),
        );
}
