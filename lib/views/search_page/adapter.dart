import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/search_page/components/history_component/component.dart';
import 'package:movie/views/search_page/components/history_component/state.dart';

import 'state.dart';

class SearchPageAdapter extends DynamicFlowAdapter<SearchPageState> {
  SearchPageAdapter()
      : super(
          pool: <String, Component<Object>>{
            'history':HistoryComponent()
          },
          connector: _SearchPageConnector(),
          );
}

class _SearchPageConnector extends ConnOp<SearchPageState, List<ItemBean>> {
  @override
  List<ItemBean> get(SearchPageState state) {
    List<ItemBean> items=<ItemBean>[];
    items.add(ItemBean('history',HistoryState()));
    return items;
  }

  @override
  void set(SearchPageState state, List<ItemBean> items) {
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
