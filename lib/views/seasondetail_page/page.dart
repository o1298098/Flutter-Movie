import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/seasondetail_page/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SeasonDetailPage extends Page<SeasonDetailPageState, Map<String, dynamic>> {
  SeasonDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SeasonDetailPageState>(
                adapter: SeasonDetailAdapter(),
                slots: <String, Dependent<SeasonDetailPageState>>{
                }),
            middleware: <Middleware<SeasonDetailPageState>>[
            ],);

}
