import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PlayerComponent extends Component<PlayerState> {
  PlayerComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          shouldUpdate: (o, n) {
            return o.playerType != n.playerType ||
                o.streamLink != n.streamLink ||
                o.streamLinkId != n.streamLinkId ||
                o.streamInBrowser != n.streamInBrowser ||
                o.useVideoSourceApi != n.useVideoSourceApi ||
                o.needAd != n.needAd ||
                o.background != n.background ||
                o.loading != n.loading;
          },
          dependencies: Dependencies<PlayerState>(
              adapter: null, slots: <String, Dependent<PlayerState>>{}),
        );
}
