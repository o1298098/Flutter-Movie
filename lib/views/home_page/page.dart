import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/home_page/components/movie_component/component.dart';
import 'package:movie/views/home_page/components/searchbar_component/component.dart';

import 'components/movie_component/state.dart';
import 'components/searchbar_component/state.dart';
import 'components/tv_component/component.dart';
import 'components/tv_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HomePage extends Page<HomePageState, Map<String, dynamic>> {
  HomePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<HomePageState>(
                adapter: null,
                slots: <String, Dependent<HomePageState>>{
                  'searchbar':SearchBarComponent().asDependent(SearchBarConnector()),
                  'moviecells':MovieCellsComponent().asDependent(MovieCellsConnector()),
                  'tvcells':TVCellsComponent().asDependent(TVCellsConnector())
                }),
            middleware: <Middleware<HomePageState>>[
            ],);

}
