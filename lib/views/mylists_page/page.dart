import 'package:fish_redux/fish_redux.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MyListsPage extends Page<MyListsPageState, Map<String, dynamic>> {
  @override
  CustomstfState<MyListsPageState> createState()=>CustomstfState<MyListsPageState> ();
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
