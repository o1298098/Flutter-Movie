import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

enum DownloadPageAction {
  action,
  setDownloadTask,
  createTask,
  startAllTasks,
  pauseAllTasks
}

class DownloadPageActionCreator {
  static Action onAction() {
    return const Action(DownloadPageAction.action);
  }

  static Action setDownloadTaks(List<DownloadTask> task) {
    return Action(DownloadPageAction.setDownloadTask, payload: task);
  }

  static Action createTask() {
    return const Action(DownloadPageAction.createTask);
  }

  static Action startAllTasks() {
    return const Action(DownloadPageAction.startAllTasks);
  }

  static Action pauseAllTasks() {
    return const Action(DownloadPageAction.pauseAllTasks);
  }
}
