import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class HeaderComponent extends Component<HeaderState> {
  HeaderComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.user != newState.user;
          },
          view: buildView,
          dependencies: Dependencies<HeaderState>(
              adapter: null, slots: <String, Dependent<HeaderState>>{}),
        );
}
