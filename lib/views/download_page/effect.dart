import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'action.dart';
import 'state.dart';

Effect<DownloadPageState> buildEffect() {
  return combineEffects(<Object, Effect<DownloadPageState>>{
    DownloadPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<DownloadPageState> ctx) async {}

void _onInit(Action action, Context<DownloadPageState> ctx) async {
  final _task = await FlutterDownloader.loadTasks();
  ctx.dispatch(DownloadPageActionCreator.setDownloadTaks(_task));
}
