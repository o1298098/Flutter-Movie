import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/api/graphql_client.dart';
import 'action.dart';
import 'state.dart';

Effect<TestPageState> buildEffect() {
  return combineEffects(<Object, Effect<TestPageState>>{
    TestPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<TestPageState> ctx) {}
void _onInit(Action action, Context<TestPageState> ctx) {
  var res = BaseGraphQLClient.instance
      .castListSubscription("WaViBxaJwEbRIzc0Jx3K4RM4fr02");
  ctx.dispatch(TestPageActionCreator.setData(res));

  var res2 = BaseGraphQLClient.instance.tvShowCommentSubscription(1399);
  ctx.dispatch(TestPageActionCreator.setData2(res2));
}

void _onDispose(Action action, Context<TestPageState> ctx) {}
