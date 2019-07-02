import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/coming_page/components/movie_component/component.dart';
import 'package:movie/views/coming_page/components/movie_component/state.dart';

import 'components/tv_component/component.dart';
import 'components/tv_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ComingPage extends Page<ComingPageState, Map<String, dynamic>> {
  ComingPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ComingPageState>(
                adapter: null,
                slots: <String, Dependent<ComingPageState>>{
                  'movielist':MovieListComponent().asDependent(MovieListConnector()),
                  'tvlist':TVListComponent().asDependent(TVListConnector())
                }),
            middleware: <Middleware<ComingPageState>>[
            ],);

}
