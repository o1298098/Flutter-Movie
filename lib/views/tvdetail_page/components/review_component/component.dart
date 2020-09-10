import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class ReviewComponent extends Component<ReviewState> {
  ReviewComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.reviewResults != newState.reviewResults;
          },
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<ReviewState>(
              adapter: null, slots: <String, Dependent<ReviewState>>{}),
        );
}
