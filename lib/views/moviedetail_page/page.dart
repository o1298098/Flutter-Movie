import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/moviedetail_page/components/keywords_component/component.dart';
import 'package:movie/views/moviedetail_page/components/keywords_component/state.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MovieDetailPage extends Page<MovieDetailPageState, Map<String, dynamic>> {
  MovieDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MovieDetailPageState>(
                adapter: null,
                slots: <String, Dependent<MovieDetailPageState>>{
                  'keywords':KeyWordsComponent().asDependent(KeyWordsConnector()),
                }),
            middleware: <Middleware<MovieDetailPageState>>[
            ],);
}
