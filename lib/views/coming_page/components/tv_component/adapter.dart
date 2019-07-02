import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/coming_page/components/tv_component/shimmercell_component/component.dart';
import 'package:movie/views/coming_page/components/tv_component/shimmercell_component/state.dart';
import 'package:movie/views/coming_page/components/tv_component/tvcell_component/component.dart';

import 'state.dart';
import 'tvcell_component/state.dart';

class TVlistAdapter extends DynamicFlowAdapter<TVListState> {
  TVlistAdapter()
      : super(
          pool: <String, Component<Object>>{
            'tvcell':TVCellComponent(),
            'shimmercell':ShimmerCellComponent()
          },
          connector: _TVlistConnector(),
          );
}

class _TVlistConnector extends ConnOp<TVListState, List<ItemBean>> {
  @override
  List<ItemBean> get(TVListState state) {
    List<ItemBean> items=new List<ItemBean>();
    for(int i=0;i<state.tvcoming.results.length;i++)
    {
      items.add(ItemBean('tvcell',TVCellState(tvResult: state.tvcoming.results[i],index: i)));
    }
    items.add(ItemBean('shimmercell',ShimmerCellState(showShimmer: state.tvcoming.page==state.tvcoming.total_results&& state.tvcoming.results.length>0)));
    return items;
  }
  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
