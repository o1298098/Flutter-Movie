import 'package:fish_redux/fish_redux.dart';

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
                adapter: null,
                slots: <String, Dependent<EpisodeDetailPageState>>{
                }),
            middleware: <Middleware<EpisodeDetailPageState>>[
            ],);

}
