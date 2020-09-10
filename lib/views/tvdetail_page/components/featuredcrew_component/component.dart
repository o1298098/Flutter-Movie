import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class TvInfoComponent extends Component<TvInfoState> {
  TvInfoComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.createdBy != newState.createdBy ||
                oldState.overView != newState.overView ||
                oldState.cast != newState.cast;
          },
          view: buildView,
          dependencies: Dependencies<TvInfoState>(
              adapter: null, slots: <String, Dependent<TvInfoState>>{}),
        );
}
