import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ListDetailPage extends Page<ListDetailPageState, Map<String, dynamic>> {
  ListDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ListDetailPageState>(
                adapter: null,
                slots: <String, Dependent<ListDetailPageState>>{
                }),
            middleware: <Middleware<ListDetailPageState>>[
            ],);

}
