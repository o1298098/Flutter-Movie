import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/views/discover_page/components/movicecell_component/component.dart';

import 'components/movicecell_component/state.dart';
import 'reducer.dart';
import 'state.dart';

class DiscoverListAdapter extends DynamicFlowAdapter<DiscoverPageState> {
  DiscoverListAdapter()
      : super(
          pool: <String, Component<Object>>{
            'moviecell':MovieCellComponent(),
          },
          connector: _DiscoverConnector(),
          reducer: buildReducer(),
        );
}

class _DiscoverConnector extends ConnOp<DiscoverPageState, List<ItemBean>> {
  @override
  List<ItemBean> get(DiscoverPageState state) {
    if(state.videoListModel.results.length>0&&state.filterState.isMovie)
    {
      List<ItemBean>  r=[];
      var cells= state.videoListModel.results.map<ItemBean>((VideoListResult data) => ItemBean('moviecell',new VideoCellState()..videodata=data))
          .toList(growable: true);
      r.addAll(cells);
      return r;
    }
    else
    return <ItemBean>[];
  }

  @override
  void set(DiscoverPageState state, List<ItemBean> items) {
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
