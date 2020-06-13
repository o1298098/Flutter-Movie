import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/mylists_page/addcell_component/component.dart';
import 'package:movie/views/mylists_page/addcell_component/state.dart';

import 'adapter/adapter.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MyListsPage extends Page<MyListsPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  MyListsPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MyListsPageState>(
              adapter: NoneConn<MyListsPageState>() + MyListAdapter(),
              slots: <String, Dependent<MyListsPageState>>{
                'addCell': AddCellConnector() + AddCellComponent()
              }),
          middleware: <Middleware<MyListsPageState>>[],
        );
}
