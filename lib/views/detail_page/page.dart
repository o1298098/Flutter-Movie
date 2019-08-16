import 'package:fish_redux/fish_redux.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MovieDetailPage extends Page<MovieDetailPageState, Map<String, dynamic>> {
  @override
  CustomstfState<MovieDetailPageState> createState() =>
      CustomstfState<MovieDetailPageState>();
  MovieDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MovieDetailPageState>(
              adapter: null,
              slots: <String, Dependent<MovieDetailPageState>>{}),
          middleware: <Middleware<MovieDetailPageState>>[],
        );
}
