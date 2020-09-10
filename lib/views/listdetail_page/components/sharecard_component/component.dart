import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class ShareCardComponent extends Component<ShareCardState> {
  ShareCardComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.listDetailModel != newState.listDetailModel ||
                oldState.user != newState.user;
          },
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<ShareCardState>(
              adapter: null, slots: <String, Dependent<ShareCardState>>{}),
        );
}
