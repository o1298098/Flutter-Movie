import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

enum DownloadPageAction { action, setDownloadTask }

class DownloadPageActionCreator {
  static Action onAction() {
    return const Action(DownloadPageAction.action);
  }

  static Action setDownloadTaks(List<DownloadTask> task) {
    return Action(DownloadPageAction.setDownloadTask, payload: task);
  }
}
