import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/steam_link_page/tvshow_livestream_page/components/cast_component/state.dart';

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
              }),
          middleware: <Middleware<TvShowLiveStreamPageState>>[],
        );
}
