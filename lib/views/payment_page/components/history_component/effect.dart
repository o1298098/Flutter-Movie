import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/api/base_api.dart';
import 'action.dart';
import 'state.dart';

Effect<HistoryState> buildEffect() {
  return combineEffects(<Object, Effect<HistoryState>>{
    HistoryAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
    Lifecycle.build: _didUpdateWidget,
  });
}

void _onAction(Action action, Context<HistoryState> ctx) {}

void _onInit(Action action, Context<HistoryState> ctx) async {
  if (ctx.state.charges == null) {
    ctx.dispatch(HistoryActionCreator.loading(true));
    if (ctx.state.stripeId == null) return;
    final _baseApi = BaseApi.instance;
    final _charges = await _baseApi.getStripeCharges(ctx.state.stripeId);
    if (_charges.success)
      ctx.dispatch(HistoryActionCreator.setCharges(_charges.result));
    ctx.dispatch(HistoryActionCreator.loading(false));
  }
}

void _didUpdateWidget(Action action, Context<HistoryState> ctx) async {}

void _onDispose(Action action, Context<HistoryState> ctx) {}
