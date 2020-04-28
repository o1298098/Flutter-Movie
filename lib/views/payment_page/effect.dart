import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/base_api.dart';
import 'action.dart';
import 'state.dart';

Effect<PaymentPageState> buildEffect() {
  return combineEffects(<Object, Effect<PaymentPageState>>{
    PaymentPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<PaymentPageState> ctx) {}

void _onInit(Action action, Context<PaymentPageState> ctx) async {
  final _r = await BaseApi.transactionSearch(ctx.state.user.uid);
  if (_r != null) ctx.dispatch(PaymentPageActionCreator.setTransactions(_r));
}
