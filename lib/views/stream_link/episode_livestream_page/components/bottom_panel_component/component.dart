import 'package:fish_redux/fish_redux.dart';

import 'components/comment_component/component.dart';
import 'components/comment_component/state.dart';
import 'components/streamlink_filter_component/component.dart';
import 'components/streamlink_filter_component/state.dart';
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
                o.selectedLink != n.selectedLink ||
                o.useVideoSourceApi != n.useVideoSourceApi ||
                o.streamInBrowser != n.streamInBrowser ||
                o.userLiked != n.userLiked;
          },
          dependencies: Dependencies<BottomPanelState>(
              adapter: null,
              slots: <String, Dependent<BottomPanelState>>{
                'comments': CommentConnector() + CommentComponent(),
                'streamLinkFilter':
                    StreamLinkFilterConnector() + StreamLinkFilterComponent(),
              }),
        );
}
