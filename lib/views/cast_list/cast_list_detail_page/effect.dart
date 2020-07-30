import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/http/base_api.dart';
import 'action.dart';
import 'state.dart';

Effect<CastListDetailState> buildEffect() {
  return combineEffects(<Object, Effect<CastListDetailState>>{
    CastListDetailAction.action: _onAction,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<CastListDetailState> ctx) {}
void _onInit(Action action, Context<CastListDetailState> ctx) async {
  if (ctx.state.castList == null) return;
  final _result =
      await BaseApi.instance.getCastListDetail(ctx.state.castList.id);
  if (_result.success)
    ctx.dispatch(CastListDetailActionCreator.setListDetail(_result.result));
}
