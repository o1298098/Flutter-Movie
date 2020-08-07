import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<AccountState> buildEffect() {
  return combineEffects(<Object, Effect<AccountState>>{
    AccountAction.action: _onAction,
  });
}

void _onAction(Action action, Context<AccountState> ctx) {
}
