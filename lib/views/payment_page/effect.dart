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
  if (ctx.state.user == null) return;
  final _customer =
      await BaseApi.getBraintreeCustomer(ctx.state.user.firebaseUser.uid);
  if (_customer != null)
    ctx.dispatch(PaymentPageActionCreator.setCustomer(_customer));
  final _transaction =
      await BaseApi.transactionSearch(ctx.state.user.firebaseUser.uid);
  if (_transaction != null)
    ctx.dispatch(PaymentPageActionCreator.setTransactions(_transaction));
}
