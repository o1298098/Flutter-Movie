import 'package:fish_redux/fish_redux.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';

Effect<InfoState> buildEffect() {
  return combineEffects(<Object, Effect<InfoState>>{
    InfoAction.action: _onAction,
    InfoAction.externalTapped: _onExternalTapped
  });
}

void _onAction(Action action, Context<InfoState> ctx) {}

Future _onExternalTapped(Action action, Context<InfoState> ctx) async {
  var url = action.payload;
  if (await canLaunch(url)) {
    await launch(url);
  }
}
