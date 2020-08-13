import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SettingsState> buildEffect() {
  return combineEffects(<Object, Effect<SettingsState>>{
    SettingsAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SettingsState> ctx) {
}
