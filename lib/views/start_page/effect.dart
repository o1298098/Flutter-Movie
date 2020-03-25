import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/routes/routes.dart';
import 'action.dart';
import 'state.dart';

Effect<StartPageState> buildEffect() {
  return combineEffects(<Object, Effect<StartPageState>>{
    StartPageAction.action: _onAction,
    Lifecycle.build: _onBuild,
  });
}

void _onAction(Action action, Context<StartPageState> ctx) {}

void _onBuild(Action action, Context<StartPageState> ctx) {
  Future.delayed(Duration(milliseconds: 0), () => _pushToMainPage(ctx.context));
}

Future _pushToMainPage(BuildContext context) async {
  await Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, __, ___) {
        return Routes.routes.buildPage('mainpage', {
          'pages': List<Widget>.unmodifiable([
            Routes.routes.buildPage('homePage', null),
            Routes.routes.buildPage('discoverPage', null),
            Routes.routes.buildPage('comingPage', null),
            Routes.routes.buildPage('accountPage', null)
          ])
        });
      },
      settings: RouteSettings(name: 'mainpage')));
}
