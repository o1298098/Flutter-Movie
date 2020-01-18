import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PopularPosterComponent extends Component<PopularPosterState> {
  PopularPosterComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.popularMoives != newState.popularMoives ||
                oldState.popularTVShows != newState.popularTVShows ||
                oldState.showmovie != newState.showmovie;
          },
          clearOnDependenciesChanged: true,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PopularPosterState>(
              adapter: null, slots: <String, Dependent<PopularPosterState>>{}),
        );
}
