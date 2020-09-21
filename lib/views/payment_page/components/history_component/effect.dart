import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/api/base_api.dart';
import 'action.dart';
import 'state.dart';

Effect<HistoryState> buildEffect() {
  return combineEffects(<Object, Effect<HistoryState>>{
    HistoryAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<HistoryState> ctx) {}

void _onInit(Action action, Context<HistoryState> ctx) async {
  if (ctx.state.transactions == null) {
    ctx.dispatch(HistoryActionCreator.loading(true));
    final _baseApi = BaseApi.instance;
    final _transaction =
        await _baseApi.transactionSearch(ctx.state.user.firebaseUser.uid);
    print(_transaction.toString());
    if (_transaction.success)
      ctx.dispatch(HistoryActionCreator.setTransactions(_transaction.result));
    ctx.dispatch(HistoryActionCreator.loading(false));
  }
}

void _onDispose(Action action, Context<HistoryState> ctx) {}
