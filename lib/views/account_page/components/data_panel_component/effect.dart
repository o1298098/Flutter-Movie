import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'action.dart';
import 'state.dart';

Effect<DataPanelState> buildEffect() {
  return combineEffects(<Object, Effect<DataPanelState>>{
    DataPanelAction.action: _onAction,
    DataPanelAction.openDownloadManager: _openDownloadManager,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<DataPanelState> ctx) {}
void _onInit(Action action, Context<DataPanelState> ctx) async {
  final _task = await FlutterDownloader.loadTasks();
  if (_task != null)
    ctx.dispatch(DataPanelActionCreator.updateDownloadTask(_task));
}

void _openDownloadManager(Action action, Context<DataPanelState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('downloadPage');
}
