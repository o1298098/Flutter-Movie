import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MyListsPage extends Page<MyListsPageState, Map<String, dynamic>> {
  MyListsPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MyListsPageState>(
                adapter: null,
                slots: <String, Dependent<MyListsPageState>>{
                }),
            middleware: <Middleware<MyListsPageState>>[
            ],);

}
