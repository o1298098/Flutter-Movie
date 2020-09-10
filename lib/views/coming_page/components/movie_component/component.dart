import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MovieListComponent extends Component<MovieListState> {
  MovieListComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.page != newState.page;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MovieListState>(
              adapter: null, slots: <String, Dependent<MovieListState>>{}),
        );
}
