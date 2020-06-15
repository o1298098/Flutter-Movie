import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class HeaderComponent extends Component<HeaderState> {
  HeaderComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.airDate != newState.airDate ||
                oldState.name != newState.name ||
                oldState.overwatch != newState.overwatch ||
                oldState.posterurl != newState.posterurl ||
                oldState.seasonNumber != newState.seasonNumber ||
                oldState.images != newState.images;
          },
          view: buildView,
          dependencies: Dependencies<HeaderState>(
              adapter: null, slots: <String, Dependent<HeaderState>>{}),
        );
}
