import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'action.dart';
import 'state.dart';

Reducer<DownloadPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<DownloadPageState>>{
      DownloadPageAction.action: _onAction,
      DownloadPageAction.setDownloadTask: _setDownLoadTask
    },
  );
}

DownloadPageState _onAction(DownloadPageState state, Action action) {
  final DownloadPageState newState = state.clone();
  return newState;
}

DownloadPageState _setDownLoadTask(DownloadPageState state, Action action) {
  final List<DownloadTask> _task = action.payload;
  final DownloadPageState newState = state.clone();
  newState.downloadTask = _task;
  return newState;
}
