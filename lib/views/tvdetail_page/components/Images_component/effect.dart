import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ImagesState> buildEffect() {
  return combineEffects(<Object, Effect<ImagesState>>{
    ImagesAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ImagesState> ctx) {
}
