import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

enum DataPanelAction { action, updateDownloadTask, openDownloadManager }

class DataPanelActionCreator {
  static Action onAction() {
    return const Action(DataPanelAction.action);
  }

  static Action updateDownloadTask(List<DownloadTask> task) {
    return Action(DataPanelAction.updateDownloadTask, payload: task);
  }

  static Action openDownloadManager() {
    return const Action(DataPanelAction.openDownloadManager);
  }
}
