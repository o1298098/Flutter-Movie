import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<MyListsPageState> buildEffect() {
  return combineEffects(<Object, Effect<MyListsPageState>>{
    MyListsPageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<MyListsPageState> ctx) {
}
