import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadPageState implements Cloneable<DownloadPageState> {
  List<DownloadTask> downloadTask;

  @override
  DownloadPageState clone() {
    return DownloadPageState()..downloadTask = downloadTask;
  }
}

DownloadPageState initState(Map<String, dynamic> args) {
  DownloadPageState state = DownloadPageState();
  return state;
}
