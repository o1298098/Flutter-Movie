import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<CreateAddressState> buildEffect() {
  return combineEffects(<Object, Effect<CreateAddressState>>{
    CreateAddressAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CreateAddressState> ctx) {
}
