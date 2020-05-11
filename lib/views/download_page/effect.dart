import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:movie/models/download_queue.dart';
import 'package:path_provider/path_provider.dart';
import 'action.dart';
import 'state.dart';

Effect<DownloadPageState> buildEffect() {
  return combineEffects(<Object, Effect<DownloadPageState>>{
    DownloadPageAction.action: _onAction,
    DownloadPageAction.createTask: _createTask,
    DownloadPageAction.startAllTasks: _startAllTasks,
    DownloadPageAction.pauseAllTasks: _pauseAllTasks,
    DownloadPageAction.taskCellActionTapped: _taskCellActionTapped,
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
      fileName: ctx.state.name + _getFileExtension(ctx.state.streamAddress),
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

void _taskCellActionTapped(
    Action action, Context<DownloadPageState> ctx) async {
  DownloadQueue _task = action.payload;
  bool _shouldRefesh = true;
  if (_task == null) return;
  switch (_task.status.value) {
    case 1:
      await FlutterDownloader.pause(taskId: _task.taskId);
      break;
    case 2:
      await FlutterDownloader.pause(taskId: _task.taskId);
      break;
    case 6:
      await FlutterDownloader.resume(taskId: _task.taskId);
      break;
    case 3:
      await FlutterDownloader.open(taskId: _task.taskId);
      _shouldRefesh = false;
      break;
    case 4:
      await FlutterDownloader.cancel(taskId: _task.taskId);
      break;
    case 5:
      await FlutterDownloader.retry(taskId: _task.taskId);
      break;
    case 0:
      await FlutterDownloader.remove(taskId: _task.taskId);
      break;
  }
  if (_shouldRefesh)
    ctx.dispatch(DownloadPageActionCreator.setDownloadTaks(
        await FlutterDownloader.loadTasks()));
}

Future<String> _findLocalPath() async {
  final directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();
  return directory.path;
}

String _getFileExtension(String address) {
  List<String> _fileExtensions = ['mp4', 'm3u8', 'mkv', 'mov', 'webm'];
  String _fileExtension = address.split('.').last ?? '';
  return _fileExtensions.contains(_fileExtension) ? '.$_fileExtension' : '';
}
