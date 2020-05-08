import 'dart:isolate';
import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/download_queue.dart';
import 'package:movie/style/themestyle.dart';

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
          child: Container(
            decoration: BoxDecoration(
              color: _theme.backgroundColor,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(Adapt.px(80))),
            ),
            child: Column(
              children: [
                SizedBox(height: Adapt.px(80)),
                _DownLoadTaskList(
                  tasks: state.downloadTask,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _TaskItem extends StatelessWidget {
  final String title;
  final double progress;
  final DownloadTaskStatus status;
  const _TaskItem({this.title, this.progress = 0.0, this.status});
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: progress * Adapt.screenW(),
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
                      'XXXXXXXXXXXXXX',
                      style: TextStyle(
                        fontSize: Adapt.px(28),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: Adapt.px(10)),
                    Text(
                      'Added May 5, 20:00',
                      style: TextStyle(
                        fontSize: Adapt.px(26),
                        color: const Color(0xFF9E9E9E),
                      ),
                    )
                  ]),
            ),
            Container(
              width: Adapt.px(65),
              height: Adapt.px(65),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(20)),
                color: Colors.grey[200],
              ),
              child: Icon(
                status == DownloadTaskStatus.running
                    ? Icons.pause
                    : Icons.file_download,
                color: status == DownloadTaskStatus.running
                    ? Colors.red
                    : Colors.blueAccent,
                size: Adapt.px(35),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

class _DownLoadTaskList extends StatefulWidget {
  final List<DownloadTask> tasks;
  const _DownLoadTaskList({this.tasks});
  @override
  _DownLoadTaskListState createState() => _DownLoadTaskListState();
}

class _DownLoadTaskListState extends State<_DownLoadTaskList> {
  ReceivePort _port = ReceivePort();
  List<DownloadQueue> tasks;
  @override
  void initState() {
    super.initState();

    tasks = List<DownloadQueue>();
    widget.tasks.forEach((e) {
      tasks.add(DownloadQueue(
          taskId: e.taskId,
          url: e.url,
          filename: e.filename,
          progress: e.progress,
          status: e.status,
          savedDir: e.savedDir,
          timeCreated: e.timeCreated));
    });

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String _id = data[0];
      DownloadTaskStatus _status = data[1];
      int _progress = data[2];
      final _task = tasks.singleWhere((e) => e.taskId == _id);
      if (_task != null) {
        _task.progress = _progress;
        _task.status = _status;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => Divider(height: 0),
      itemCount: 5,
      itemBuilder: (_, index) => _TaskItem(
        status: index.isEven
            ? DownloadTaskStatus.running
            : DownloadTaskStatus.paused,
        progress: 0.1 * index,
      ),
    ));
  }
}
