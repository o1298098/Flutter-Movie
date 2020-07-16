import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class BottomPanelComponent extends Component<BottomPanelState> {
  BottomPanelComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          clearOnDependenciesChanged: true,
          shouldUpdate: (o, n) {
            return o.commentCount != n.commentCount ||
                o.likeCount != n.likeCount ||
                o.streamLinks != n.streamLinks ||
                o.useVideoSourceApi != n.useVideoSourceApi ||
                o.streamInBrowser != n.streamInBrowser ||
                o.userLiked != n.userLiked;
          },
          dependencies: Dependencies<BottomPanelState>(
              adapter: null, slots: <String, Dependent<BottomPanelState>>{}),
        );
}
