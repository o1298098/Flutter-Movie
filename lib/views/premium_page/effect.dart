import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/base_api.dart';
import 'action.dart';
import 'state.dart';

Effect<PremiumPageState> buildEffect() {
  return combineEffects(<Object, Effect<PremiumPageState>>{
    PremiumPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<PremiumPageState> ctx) {}

Future _onInit(Action action, Context<PremiumPageState> ctx) async {
  if (ctx.state?.user?.premium != null) {
    if (ctx.state.user.premium.subscriptionId == null) return;
    var _subscription = await BaseApi.getPremiumSubscription(
        ctx.state.user.premium.subscriptionId);
    if (_subscription != null)
      ctx.dispatch(PremiumPageActionCreator.setSubscription(_subscription));
  }
}
