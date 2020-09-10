import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TitleComponent extends Component<TitleState> {
  TitleComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          shouldUpdate: (oldState, newState) {
            return oldState.name != newState.name ||
                oldState.genres != newState.genres ||
                oldState.contentRatings != newState.contentRatings ||
                oldState.vote != newState.vote ||
                oldState.overview != newState.overview;
          },
          view: buildView,
          dependencies: Dependencies<TitleState>(
              adapter: null, slots: <String, Dependent<TitleState>>{}),
        );
}
