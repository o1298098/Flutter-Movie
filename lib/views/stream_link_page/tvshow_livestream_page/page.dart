import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/stream_link_page/tvshow_livestream_page/components/cast_component/state.dart';
import 'package:movie/views/stream_link_page/tvshow_livestream_page/components/loading_component/component.dart';
import 'package:movie/views/stream_link_page/tvshow_livestream_page/components/loading_component/state.dart';
import 'package:movie/views/stream_link_page/tvshow_livestream_page/components/player_componet/component.dart';
import 'package:movie/views/stream_link_page/tvshow_livestream_page/components/player_componet/state.dart';
import 'package:movie/views/stream_link_page/tvshow_livestream_page/components/stream_link_component/component.dart';
import 'package:movie/views/stream_link_page/tvshow_livestream_page/components/stream_link_component/state.dart';

import 'components/cast_component/component.dart';
import 'components/comment_component/component.dart';
import 'components/comment_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TvShowLiveStreamPage
    extends Page<TvShowLiveStreamPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  TvShowLiveStreamPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TvShowLiveStreamPageState>(
              adapter: null,
              slots: <String, Dependent<TvShowLiveStreamPageState>>{
                'commentComponent': CommentConnector() + CommentComponent(),
                'castComponent': CastConnector() + CastComponent(),
                'player': TvPlayerConnector() + TvPlayerComponent(),
                'streamLink': StreamLinkConnector() + StreamLinkComponent(),
                'loading': LoadingConnector() + LoadingComponent(),
              }),
          middleware: <Middleware<TvShowLiveStreamPageState>>[],
        );
}
