import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CastListDetailPage extends Page<CastListDetailState, Map<String, dynamic>> {
  CastListDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CastListDetailState>(
                adapter: null,
                slots: <String, Dependent<CastListDetailState>>{
                }),
            middleware: <Middleware<CastListDetailState>>[
            ],);

}
