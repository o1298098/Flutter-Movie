import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:movie/models/download_queue.dart';
import 'action.dart';
import 'state.dart';

Effect<DownloadPageState> buildEffect() {
  return combineEffects(<Object, Effect<DownloadPageState>>{
    DownloadPageAction.action: _onAction,
    DownloadPageAction.startAllTasks: _startAllTasks,
    DownloadPageAction.pauseAllTasks: _pauseAllTasks,
    DownloadPageAction.taskCellActionTapped: _taskCellActionTapped,
    DownloadPageAction.deleteTask: _deleteTask,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<DownloadPageState> ctx) async {}

void _onInit(Action action, Context<DownloadPageState> ctx) async {
  final _task = await FlutterDownloader.loadTasks();
  ctx.dispatch(DownloadPageActionCreator.setDownloadTaks(_task));
}

void _onDispose(Action action, Context<DownloadPageState> ctx) async {}

void _deleteTask(Action action, Context<DownloadPageState> ctx) async {
  final String _taskId = action.payload;
  if (_taskId == null) return;
  await FlutterDownloader.remove(taskId: _taskId, shouldDeleteContent: true);
  ctx.dispatch(DownloadPageActionCreator.setDownloadTaks(
      await FlutterDownloader.loadTasks()));
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
