import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/stream_link_convert/stream_link_convert_factory.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';
import 'package:movie/models/download_queue.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/widgets/arrow_clipper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';

class DownloadMenu extends StatelessWidget {
  final String movieName;
  final List<MovieStreamLink> links;
  final Function(MovieStreamLink) playVideo;
  const DownloadMenu({this.links, this.movieName, this.playVideo});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _backGroundColor = _theme.brightness == Brightness.light
        ? const Color(0xFF25272E)
        : _theme.primaryColorDark;
    final double _width = 220;
    final double _arrowSize = 20.0;
    return Positioned(
      bottom: 80,
      left: Adapt.px(375) - _width / 2,
      width: _width,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: ArrowClipper(),
                  child: Container(
                    width: _arrowSize,
                    height: _arrowSize,
                    color: _backGroundColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                padding: EdgeInsets.all(20),
                height: 250,
                decoration: BoxDecoration(
                  color: _backGroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(children: [
                  Expanded(
                    child: _DownLoadTaskList(
                      movieName: movieName,
                      onPlayVideo: playVideo,
                      list: links
                          .where((e) =>
                              e.streamLinkType.name == 'WebView' ||
                              e.streamLinkType.name == 'other')
                          .toList(),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DownLoadTaskList extends StatefulWidget {
  final String movieName;
  final Function(MovieStreamLink) onPlayVideo;
  final List<MovieStreamLink> list;
  const _DownLoadTaskList(
      {Key key, this.list, this.movieName, this.onPlayVideo})
      : super(key: key);
  @override
  _DownLoadTaskListState createState() => _DownLoadTaskListState();
}

class _DownLoadTaskListState extends State<_DownLoadTaskList> {
  ReceivePort _port = ReceivePort();
  List<DownloadQueue> _queue;
  List<DownloadTask> _downloadTasks;
  @override
  void initState() {
    super.initState();
    updateTasks();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String _id = data[0];
      DownloadTaskStatus _status = data[1];
      int _progress = data[2];
      final _task = _queue?.singleWhere(
        (e) => e.taskId == _id,
        orElse: () => null,
      );
      if (_task != null) {
        _task.progress = _progress < 0 ? 0 : _progress;
        _task.status = _status;
        setState(() {});
      }
    });
  }

  Future updateTasks() async {
    _downloadTasks = await FlutterDownloader.loadTasks();
    _queue = [];
    if (_queue != null)
      _downloadTasks?.forEach((e) {
        //FlutterDownloader.remove(taskId: e.taskId);
        _queue.add(DownloadQueue(
            taskId: e.taskId,
            url: e.url,
            filename: e.filename,
            progress: e.progress,
            status: e.status,
            savedDir: e.savedDir,
            timeCreated: e.timeCreated));
      });
    _queue.sort((a, b) => b.timeCreated.compareTo(a.timeCreated));
    setState(() {});
  }

  Future _createTask(MovieStreamLink link) async {
    try {
      final _taskName = '${widget.movieName}_${link.sid}';
      final _localPath =
          (await _findLocalPath()) + Platform.pathSeparator + 'Download';
      final _savedDir = Directory(_localPath);
      bool hasExisted = await _savedDir.exists();
      if (!hasExisted) {
        _savedDir.create();
      }
      String _downloadAddress;
      if (link.streamLinkType.name == 'WebView') {
        _downloadAddress =
            await StreamLinkConvertFactory.instance.getLink(link.streamLink);
        print(_downloadAddress);
      } else
        _downloadAddress = link.streamLink;
      if (_downloadAddress == null)
        return Toast.show('Invalid download address', context);
      final _taskId = await FlutterDownloader.enqueue(
        url: _downloadAddress,
        fileName: _taskName + _getFileExtension(_downloadAddress),
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true,
      );
      print(_taskId);
      await updateTasks();
    } on Exception catch (_) {
      print(_);
    }
  }

  Future _retryTask(DownloadQueue queue) async {
    await FlutterDownloader.retry(taskId: queue.taskId);
    await updateTasks();
    return;
  }

  void _playLoaclFile(MovieStreamLink link) {
    final _taskName = '${widget.movieName}_${link.sid}';
    final _task = _queue?.firstWhere((e) => e.filename.contains(_taskName),
        orElse: () => null);
    if (_task == null) return;
    MovieStreamLink _link = MovieStreamLink(link.toString());
    _link.streamLink = '${_task.savedDir}/${_task.filename}';
    _link.streamLinkType.id = 99;
    _link.streamLinkType.name = 'localFile';
    widget.onPlayVideo(_link);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  String _getFileExtension(String address) {
    List<String> _fileExtensions = ['.mp4', '.m3u8', '.mkv', '.mov', '.webm'];
    String _fileExtension;
    for (var q in _fileExtensions) {
      if (address.contains(q)) {
        _fileExtension = q;
        break;
      }
    }
    return _fileExtension;
  }

  @override
  void didUpdateWidget(_DownLoadTaskList oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, __) => SizedBox(height: 15),
      itemCount: widget.list?.length ?? 0,
      itemBuilder: (_, index) {
        final _link = widget.list[index];
        final _taskName = '${widget.movieName}_${_link.sid}';
        final _task = _queue?.firstWhere((e) => e.filename.contains(_taskName),
            orElse: () => null);
        return _DownLoadCell(
          link: _link,
          queue: _task,
          downloadTap: _createTask,
          retryTap: _retryTask,
          openFileTap: _playLoaclFile,
        );
      },
    );
  }
}

class _DownLoadCell extends StatelessWidget {
  final MovieStreamLink link;
  final DownloadQueue queue;
  final Function(MovieStreamLink) downloadTap;
  final Function(MovieStreamLink) openFileTap;
  final Function(DownloadQueue) retryTap;
  const _DownLoadCell({
    this.link,
    this.queue,
    this.downloadTap,
    this.openFileTap,
    this.retryTap,
  });
  @override
  Widget build(BuildContext context) {
    final Color _baseColor = const Color(0xFFFFFFFF);
    final String _name = _getDomain(link.streamLink, link.streamLinkType.name);
    return Container(
      child: Row(
        children: [
          Container(
              constraints: BoxConstraints(maxWidth: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                    maxLines: 1,
                    style: TextStyle(
                      color: _baseColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    link.language.name,
                    style: TextStyle(
                      fontSize: 10,
                      color: const Color(0xFF717171),
                    ),
                  )
                ],
              )),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              border: Border.all(color: _baseColor),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              link.quality.name,
              style: TextStyle(
                fontSize: 6,
                color: _baseColor,
              ),
            ),
          ),
          Spacer(),
          _DownloadIcon(
            queue: queue,
            onStart: () => downloadTap(link),
            onRetry: () => retryTap(queue),
            openFile: () => openFileTap(link),
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}

class _CircularProgressIndicator extends StatelessWidget {
  final int value;
  const _CircularProgressIndicator({this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        value: value != null ? value / 100 : null,
        backgroundColor: const Color(0xFF717171),
        valueColor: AlwaysStoppedAnimation(Color(0xFFFFFFFF)),
      ),
    );
  }
}

class _DownloadIcon extends StatefulWidget {
  final Function onStart;
  final Function onRetry;
  final Function openFile;
  final DownloadQueue queue;
  const _DownloadIcon({this.onRetry, this.onStart, this.openFile, this.queue});
  @override
  _DownloadIconState createState() => _DownloadIconState();
}

class _DownloadIconState extends State<_DownloadIcon> {
  final Color _baseColor = const Color(0xFFFFFFFF);
  bool _hasTask = false;
  bool _loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(_DownloadIcon oldWidget) {
    if (oldWidget.queue != widget.queue) {
      setState(() {
        _hasTask = widget.queue != null;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  _setLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  _start() async {
    if (_loading) return;
    _setLoading(true);
    await widget.onStart();
    _setLoading(false);
  }

  _retry() async {
    if (_loading) return;
    _setLoading(true);
    await widget.onRetry();
    _setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return _CircularProgressIndicator();
    if (_hasTask)
      switch (widget.queue.status.value) {
        //runing
        //enqueued
        case 2:
        case 1:
          return _CircularProgressIndicator(
            value: widget.queue.progress,
          );
        //complete
        case 3:
          return GestureDetector(
            onTap: widget.openFile,
            child: Icon(
              Icons.play_arrow,
              size: 12,
              color: _baseColor,
            ),
          );
        case 4:
          return GestureDetector(
            onTap: _retry,
            child: Icon(
              Icons.refresh,
              size: 12,
              color: _baseColor,
            ),
          );
      }
    return GestureDetector(
      onTap: _start,
      child: Icon(
        Icons.download_sharp,
        size: 12,
        color: _baseColor,
      ),
    );
  }
}

_getDomain(String url, String type) {
  if (type.toLowerCase() == 'youtube') return 'youtube';
  if (type.toLowerCase() == 'torrent') return 'torrent';
  final _strArray = url.split('/');
  if (_strArray.length > 3) return _strArray[2];
  return url;
}
