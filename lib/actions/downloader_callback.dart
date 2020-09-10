import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';

class DownloaderCallBack {
  static void callback(String id, DownloadTaskStatus status, int progress) {
    print('id:$id, status:$status, progress:$progress');
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }
}
