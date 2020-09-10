import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/mylists_page/listcell_component/component.dart';
import 'package:movie/views/mylists_page/state.dart';

import 'reducer.dart';

class MyListAdapter extends SourceFlowAdapter<MyListsPageState> {
  MyListAdapter()
      : super(
          pool: <String, Component<Object>>{'listCell': ListCellComponent()},
          reducer: buildReducer(),
        );
}
