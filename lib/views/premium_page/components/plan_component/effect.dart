import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/globalbasestate/action.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/views/premium_page/action.dart';
import 'action.dart';
import 'state.dart';

Effect<PlanState> buildEffect() {
  return combineEffects(<Object, Effect<PlanState>>{
    PlanAction.action: _onAction,
    PlanAction.unSubscribe: _unSubscribe,
  });
}

void _onAction(Action action, Context<PlanState> ctx) {}

Future _unSubscribe(Action action, Context<PlanState> ctx) async {
  ctx.dispatch(PremiumPageActionCreator.loading(true));
  if (ctx.state?.user?.premium != null) {
    final _baseApi = BaseApi.instance;
    final _result = await _baseApi.cancelSubscription(ctx.state.user.premium);
    if (_result.success)
      GlobalStore.store
          .dispatch(GlobalActionCreator.setUserPremium(_result.result));
  }
  ctx.dispatch(PremiumPageActionCreator.loading(false));
}
