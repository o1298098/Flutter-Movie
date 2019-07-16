import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/search_page/adapter.dart';
import 'package:movie/views/search_page/components/searchbar_component/component.dart';

import 'components/searchbar_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SearchPage extends Page<SearchPageState, Map<String, dynamic>> {
  SearchPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SearchPageState>(
                adapter:NoneConn<SearchPageState>()+ SearchPageAdapter(),
                slots: <String, Dependent<SearchPageState>>{
                  'searchbar':SearchBarConnector()+SearchBarComponent()
                }),
            middleware: <Middleware<SearchPageState>>[
            ],);

}
