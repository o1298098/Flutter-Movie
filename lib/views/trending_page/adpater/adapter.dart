import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/trending_page/components/trendingcell_component/component.dart';
import 'package:movie/views/trending_page/state.dart';

import 'reducer.dart';

class TrendingAdapter extends SourceFlowAdapter<TrendingPageState> {
  TrendingAdapter()
      : super(
          pool: <String, Component<Object>>{
            'trendingCell': TrendingCellComponent()
          },
          reducer: buildReducer(),
        );
}
