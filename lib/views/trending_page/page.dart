import 'package:fish_redux/fish_redux.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:movie/views/trending_page/components/fliter_component/component.dart';

import 'adpater/adapter.dart';
import 'components/fliter_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TrendingPage extends Page<TrendingPageState, Map<String, dynamic>> {
  @override
  CustomstfState<TrendingPageState> createState() =>
      CustomstfState<TrendingPageState>();
  TrendingPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TrendingPageState>(
              adapter: NoneConn<TrendingPageState>() + TrendingAdapter(),
              slots: <String, Dependent<TrendingPageState>>{
                'fliter': FliterConnector() + FliterComponent()
              }),
          middleware: <Middleware<TrendingPageState>>[],
        );
}
