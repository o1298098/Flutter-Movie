import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class BodyComponent extends Component<BodyState> {
  BodyComponent()
      : super(
          view: buildView,
          shouldUpdate: (oldState, newState) {
            return false;
          },
          dependencies: Dependencies<BodyState>(
              adapter: null, slots: <String, Dependent<BodyState>>{}),
        );
}
