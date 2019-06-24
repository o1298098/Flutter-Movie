import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SearchPageState> buildEffect() {
  return combineEffects(<Object, Effect<SearchPageState>>{
    SearchPageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SearchPageState> ctx) {
}
