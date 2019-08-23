import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GalleryPageState> buildEffect() {
  return combineEffects(<Object, Effect<GalleryPageState>>{
    GalleryPageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GalleryPageState> ctx) {
}
