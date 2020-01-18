import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class BackGroundComponent extends Component<BackGroundState> {
  BackGroundComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.photoUrl != newState.photoUrl;
          },
          view: buildView,
          dependencies: Dependencies<BackGroundState>(
              adapter: null, slots: <String, Dependent<BackGroundState>>{}),
        );
}
