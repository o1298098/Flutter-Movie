import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<EpisodeHeaderState> buildEffect() {
  return combineEffects(<Object, Effect<EpisodeHeaderState>>{
    EpisodeHeaderAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose
  });
}

void _onAction(Action action, Context<EpisodeHeaderState> ctx) {}
void _onInit(Action action, Context<EpisodeHeaderState> ctx) {
  //ctx.state.tickerProvider=ctx.stfState as CustomstfState;
}
void _onDispose(Action action, Context<EpisodeHeaderState> ctx) {}
