import 'package:fish_redux/fish_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<BottomPanelState> buildEffect() {
  return combineEffects(<Object, Effect<BottomPanelState>>{
    BottomPanelAction.action: _onAction,
    BottomPanelAction.useVideoSource: _useVideoSource,
    BottomPanelAction.streamInBrowser: _streamInBrowser,
  });
}

void _onAction(Action action, Context<BottomPanelState> ctx) {}

void _useVideoSource(Action action, Context<BottomPanelState> ctx) async {
  final bool _b = action.payload;
  final _pre = await SharedPreferences.getInstance();
  _pre.setBool('useVideoSourceApi', _b);
  ctx.dispatch(BottomPanelActionCreator.setUseVideoSource(_b));
}

void _streamInBrowser(Action action, Context<BottomPanelState> ctx) async {
  final bool _b = action.payload;
  final _pre = await SharedPreferences.getInstance();
  _pre.setBool('streamInBrowser', _b);
  ctx.dispatch(BottomPanelActionCreator.setStreamInBrowser(_b));
}
