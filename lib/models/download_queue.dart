import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadQueue {
  final String taskId;
  DownloadTaskStatus status;
  int progress;
  final String url;
  final String filename;
  final String savedDir;
  final int timeCreated;

  DownloadQueue(
      {this.taskId,
      this.status,
      this.progress,
      this.url,
      this.filename,
      this.savedDir,
      this.timeCreated});

  @override
  String toString() =>
      "DownloadQueue(taskId: $taskId, status: $status, progress: $progress, url: $url, filename: $filename, savedDir: $savedDir, timeCreated: $timeCreated)";
}
