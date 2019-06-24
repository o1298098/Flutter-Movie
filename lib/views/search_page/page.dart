import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SearchPagePage extends Page<SearchPageState, Map<String, dynamic>> {
  SearchPagePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SearchPageState>(
                adapter: null,
                slots: <String, Dependent<SearchPageState>>{
                }),
            middleware: <Middleware<SearchPageState>>[
            ],);

}
