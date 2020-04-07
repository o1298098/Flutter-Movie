import 'package:fish_redux/fish_redux.dart';
import 'components/comment_compoent/component.dart';
import 'components/comment_compoent/state.dart';
import 'components/loading_component/component.dart';
import 'components/loading_component/state.dart';
import 'components/player_component/component.dart';
import 'components/player_component/state.dart';
import 'components/stream_link_component/component.dart';
import 'components/stream_link_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LiveStreamPage extends Page<LiveStreamPageState, Map<String, dynamic>> {
  LiveStreamPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<LiveStreamPageState>(
              adapter: null,
              slots: <String, Dependent<LiveStreamPageState>>{
                'player': PlayerConnector() + PlayerComponent(),
                'streamLinks': StreamLinkConnector() + StreamLinkComponent(),
                'comments': CommentConnector() + CommentComponent(),
                'loading': LoadingConnector() + LoadingComponent(),
              }),
          middleware: <Middleware<LiveStreamPageState>>[],
        );
}
