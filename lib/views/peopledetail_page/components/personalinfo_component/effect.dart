import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<PersonalInfoState> buildEffect() {
  return combineEffects(<Object, Effect<PersonalInfoState>>{
    PersonalInfoAction.action: _onAction,
  });
}

void _onAction(Action action, Context<PersonalInfoState> ctx) {
}
