import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/episodedetail_page/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class EpisodeDetailPage extends Page<EpisodeDetailPageState, Map<String, dynamic>> {
  EpisodeDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<EpisodeDetailPageState>(
                adapter:NoneConn<EpisodeDetailPageState>() +EpisodeDetailAdapter(),
                slots: <String, Dependent<EpisodeDetailPageState>>{
                }),
            middleware: <Middleware<EpisodeDetailPageState>>[
            ],);

}
