import 'package:fish_redux/fish_redux.dart';
import 'package:movie/actions/apihelper.dart';
import 'action.dart';
import 'state.dart';

Effect<LoginPageState> buildEffect() {
  return combineEffects(<Object, Effect<LoginPageState>>{
    LoginPageAction.action: _onAction,
    LoginPageAction.loginclicked:_onLoginClicked

  });
}

void _onAction(Action action, Context<LoginPageState> ctx) {
}
void _onLoginClicked(Action action, Context<LoginPageState> ctx) async{
  await ApiHelper.createSessionWithLogin(ctx.state.account, ctx.state.pwd);
}
