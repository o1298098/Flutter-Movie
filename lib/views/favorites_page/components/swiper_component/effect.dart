import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SwiperState> buildEffect() {
  return combineEffects(<Object, Effect<SwiperState>>{
    SwiperAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SwiperState> ctx) {
}
