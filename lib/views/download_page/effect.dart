import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'action.dart';
import 'state.dart';

Effect<DownloadPageState> buildEffect() {
  return combineEffects(<Object, Effect<DownloadPageState>>{
    DownloadPageAction.action: _onAction,
    DownloadPageAction.createTask: _createTask,
    DownloadPageAction.startAllTasks: _startAllTasks,
    DownloadPageAction.pauseAllTasks: _pauseAllTasks,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<DownloadPageState> ctx) async {}

void _onInit(Action action, Context<DownloadPageState> ctx) async {
  Object _ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: _ticker, duration: Duration(milliseconds: 300));
  final _task = await FlutterDownloader.loadTasks();
  ctx.dispatch(DownloadPageActionCreator.setDownloadTaks(_task));
}

void _onDispose(Action action, Context<DownloadPageState> ctx) async {
  ctx.state.animationController?.dispose();
}

void _createTask(Action action, Context<DownloadPageState> ctx) async {
  ctx.state.animationController.forward();
  try {
    final _localPath =
        (await _findLocalPath()) + Platform.pathSeparator + 'Download';
    final _savedDir = Directory(_localPath);
    bool hasExisted = await _savedDir.exists();
    if (!hasExisted) {
      _savedDir.create();
    }
    final _taskId = await FlutterDownloader.enqueue(
      url: ctx.state.streamAddress,
      fileName: ctx.state.name,
      savedDir: _localPath,
      showNotification: true,
      openFileFromNotification: true,
    );
    print(_taskId);
    ctx.dispatch(DownloadPageActionCreator.setDownloadTaks(
        await FlutterDownloader.loadTasks()));
  } on Exception catch (_) {
    print(_);
  }
}

void _startAllTasks(Action action, Context<DownloadPageState> ctx) async {
  if (ctx.state.downloadTask == null) return;
  ctx.state.downloadTask.forEach((e) {
    if (e.status == DownloadTaskStatus.paused)
      FlutterDownloader.resume(taskId: e.taskId);
    else if (e.status == DownloadTaskStatus.failed)
      FlutterDownloader.retry(taskId: e.taskId);
  });
  ctx.dispatch(DownloadPageActionCreator.setDownloadTaks(
      await FlutterDownloader.loadTasks()));
}

void _pauseAllTasks(Action action, Context<DownloadPageState> ctx) async {
  if (ctx.state.downloadTask == null) return;
  ctx.state.downloadTask.forEach((e) {
    if (e.status == DownloadTaskStatus.running ||
        e.status == DownloadTaskStatus.enqueued)
      FlutterDownloader.pause(taskId: e.taskId);
  });
  ctx.dispatch(DownloadPageActionCreator.setDownloadTaks(
      await FlutterDownloader.loadTasks()));
}

Future<String> _findLocalPath() async {
  final directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();
  return directory.path;
}
