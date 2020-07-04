import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class EpisodeLiveStreamPage extends Page<EpisodeLiveStreamState, Map<String, dynamic>> {
  EpisodeLiveStreamPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<EpisodeLiveStreamState>(
                adapter: null,
                slots: <String, Dependent<EpisodeLiveStreamState>>{
                }),
            middleware: <Middleware<EpisodeLiveStreamState>>[
            ],);

}
