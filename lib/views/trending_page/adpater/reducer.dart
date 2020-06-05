import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/trending_page/state.dart';
import '../components/filter_component/action.dart' as fliter_action;
import 'action.dart';

Reducer<TrendingPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<TrendingPageState>>{
      TrendingAdapterAction.action: _onAction,
      fliter_action.FilterAction.updateList: _updateList,
    },
  );
}

TrendingPageState _onAction(TrendingPageState state, Action action) {
  final TrendingPageState newState = state.clone();
  return newState;
}

TrendingPageState _updateList(TrendingPageState state, Action action) {
  final TrendingPageState newState = state.clone();
  newState.trending = action.payload;
  return newState;
}
