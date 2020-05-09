import 'dart:isolate';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/download_queue.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DownloadPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);

      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          brightness: _theme.brightness,
          backgroundColor: _theme.primaryColorLight,
          iconTheme: _theme.iconTheme,
          title: Text(
            'Queue',
            style: TextStyle(color: _theme.textTheme.bodyText1.color),
          ),
        ),
        body: Container(
          color: _theme.primaryColorLight,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              _NewTaskCell(
                name: state.name,
                posterUrl: state.posterUrl,
                onDownload: () =>
                    dispatch(DownloadPageActionCreator.createTask()),
              ),
              SlideTransition(
                position: Tween(begin: Offset(0, 0.2), end: Offset.zero)
                    .animate(CurvedAnimation(
                        parent: state.animationController, curve: Curves.ease)),
                child: Container(
                  decoration: BoxDecoration(
                    color: _theme.backgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(Adapt.px(60)),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: Adapt.px(40)),
                      _OperateGroup(
                        startAllTasks: () =>
                            dispatch(DownloadPageActionCreator.startAllTasks()),
                        pauseAllTasks: () =>
                            dispatch(DownloadPageActionCreator.pauseAllTasks()),
                      ),
                      SizedBox(height: Adapt.px(20)),
                      _DownLoadTaskList(
                        key: ValueKey("downloadKey"),
                        tasks: state.downloadTask,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _OperateGroup extends StatelessWidget {
  final Function startAllTasks;
  final Function pauseAllTasks;
  const _OperateGroup({this.startAllTasks, this.pauseAllTasks});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(50)),
      child: Row(children: [
        Text('Download tasks',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: Adapt.px(35))),
        Expanded(child: SizedBox()),
        GestureDetector(
          onTap: startAllTasks,
          child: Container(
            padding: EdgeInsets.all(Adapt.px(10)),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(Adapt.px(20))),
            child: Icon(Icons.file_download, color: Color(0xFFFFFFFF)),
          ),
        ),
        SizedBox(width: Adapt.px(40)),
        GestureDetector(
          onTap: pauseAllTasks,
          child: Container(
            padding: EdgeInsets.all(Adapt.px(10)),
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(Adapt.px(20))),
            child: Icon(Icons.pause, color: Color(0xFFFFFFFF)),
          ),
        ),
      ]),
    );
  }
}

class _NewTaskCell extends StatelessWidget {
  final String posterUrl;
  final String name;
  final String streamAddress;
  final Function onDownload;
  const _NewTaskCell(
      {this.name, this.posterUrl, this.streamAddress, this.onDownload});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Adapt.px(40), vertical: Adapt.px(20)),
        child: Row(
          children: [
            Container(
              width: Adapt.px(200),
              height: Adapt.px(230),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    ImageUrl.getUrl(posterUrl, ImageSize.w400),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Adapt.px(350),
              child: Text(
                name ?? '',
                style: TextStyle(
                    fontSize: Adapt.px(30), fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: Adapt.px(30)),
            GestureDetector(
              onTap: onDownload,
              child: Container(
                width: Adapt.px(100),
                height: Adapt.px(100),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(
                    Adapt.px(20),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.file_download,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class _TaskItem extends StatelessWidget {
  final DownloadQueue task;
  const _TaskItem({this.task});
  IconData _getIcon() {
    switch (task.status.value) {
      case 1:
        return Icons.pause;
      case 2:
        return Icons.pause;
      case 6:
        return Icons.file_download;
      case 3:
        return Icons.play_arrow;
      case 4:
        return Icons.close;
      case 4:
        return Icons.refresh;
      case 0:
        return Icons.warning;
      default:
        return Icons.warning;
    }
  }

  void onTap() async {
    switch (task.status.value) {
      case 1:
        await FlutterDownloader.pause(taskId: task.taskId);
        break;
      case 2:
        await FlutterDownloader.pause(taskId: task.taskId);
        break;
      case 6:
        await FlutterDownloader.resume(taskId: task.taskId);
        break;
      case 3:
        await FlutterDownloader.open(taskId: task.taskId);
        break;
      case 4:
        await FlutterDownloader.cancel(taskId: task.taskId);
        break;
      case 4:
        await FlutterDownloader.retry(taskId: task.taskId);
        break;
      case 0:
        await FlutterDownloader.cancel(taskId: task.taskId);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Stack(children: [
      task.status == DownloadTaskStatus.complete
          ? SizedBox()
          : Container(
              width: (task.progress < 0 ? 0 : task.progress) /
                  100 *
                  Adapt.screenW(),
              height: Adapt.px(180),
              color: Colors.blue.withOpacity(0.05),
            ),
      Container(
        padding: EdgeInsets.symmetric(
            vertical: Adapt.px(50), horizontal: Adapt.px(50)),
        child: Row(
          children: [
            Container(
              width: Adapt.px(80),
              height: Adapt.px(80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(20)),
                color: Colors.pink[100],
              ),
            ),
            SizedBox(width: Adapt.px(30)),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.filename ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Adapt.px(28),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: Adapt.px(10)),
                    Text(
                      'Added ${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(task.timeCreated))}',
                      style: TextStyle(
                        fontSize: Adapt.px(26),
                        color: const Color(0xFF9E9E9E),
                      ),
                    )
                  ]),
            ),
            SizedBox(width: Adapt.px(30)),
            Container(
              width: Adapt.px(65),
              height: Adapt.px(65),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(20)),
                color: _theme.primaryColorDark,
              ),
              child: GestureDetector(
                  onTap: () => onTap(),
                  child: Icon(
                    _getIcon(),
                    color: task.status == DownloadTaskStatus.running
                        ? Colors.red
                        : Colors.blueAccent,
                    size: Adapt.px(35),
                  )),
            ),
          ],
        ),
      ),
    ]);
  }
}

class _DownLoadTaskList extends StatefulWidget {
  final List<DownloadTask> tasks;
  const _DownLoadTaskList({Key key, this.tasks}) : super(key: key);
  @override
  _DownLoadTaskListState createState() => _DownLoadTaskListState();
}

class _DownLoadTaskListState extends State<_DownLoadTaskList> {
  ReceivePort _port = ReceivePort();
  List<DownloadQueue> tasks;
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
      final _task = tasks?.singleWhere((e) => e.taskId == _id) ?? null;
      if (_task != null) {
        _task.progress = _progress < 0 ? 0 : _progress;
        _task.status = _status;
        setState(() {});
      }
    });
  }

  void updateTasks() {
    tasks = List<DownloadQueue>();
    if (tasks != null)
      widget.tasks?.forEach((e) {
        tasks.add(DownloadQueue(
            taskId: e.taskId,
            url: e.url,
            filename: e.filename,
            progress: e.progress,
            status: e.status,
            savedDir: e.savedDir,
            timeCreated: e.timeCreated));
      });
    tasks.sort((a, b) => b.timeCreated.compareTo(a.timeCreated));
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  void didUpdateWidget(_DownLoadTaskList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tasks != widget.tasks) updateTasks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: tasks.length > 0
          ? ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (_, __) => Divider(height: 0),
              itemCount: tasks.length,
              itemBuilder: (_, index) => _TaskItem(
                task: tasks[index],
              ),
            )
          : Container(
              padding: EdgeInsets.only(top: Adapt.px(300)),
              child: Text(
                'empty list',
                style: TextStyle(fontSize: 18, color: Color(0xFF9E9E9E)),
              ),
            ),
    );
  }
}
