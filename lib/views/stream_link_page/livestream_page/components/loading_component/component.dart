import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class LoadingComponent extends Component<LoadingState> {
  LoadingComponent()
      : super(
          view: buildView,
          shouldUpdate: (oldState, newState) {
            return oldState.loading != newState.loading;
          },
          dependencies: Dependencies<LoadingState>(
              adapter: null, slots: <String, Dependent<LoadingState>>{}),
        );
}
