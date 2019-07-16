import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SearchPageState> buildEffect() {
  return combineEffects(<Object, Effect<SearchPageState>>{
    SearchPageAction.action: _onAction,
    Lifecycle.dispose:_onDispose,
    Lifecycle.initState:_onInit
  });
}

void _onAction(Action action, Context<SearchPageState> ctx) {
}
void _onDispose(Action action, Context<SearchPageState> ctx) {
  ctx.state.focus.dispose();
}
void _onInit(Action action, Context<SearchPageState> ctx) {
  ctx.dispatch(SearchPageActionCreator.setGlobalkey());
}
