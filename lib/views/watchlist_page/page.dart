import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class WatchlistPage extends Page<WatchlistPageState, Map<String, dynamic>> {
  WatchlistPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<WatchlistPageState>(
                adapter: null,
                slots: <String, Dependent<WatchlistPageState>>{
                }),
            middleware: <Middleware<WatchlistPageState>>[
            ],);

}
