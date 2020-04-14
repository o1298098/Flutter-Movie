import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/actions/downloader_callback.dart';
import 'package:movie/actions/github_api.dart';
import 'package:movie/actions/version_comparison.dart';
import 'package:movie/customwidgets/update_info_dialog.dart';
import 'package:movie/globalbasestate/action.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/views/detail_page/page.dart';
import 'package:movie/views/tvdetail_page/page.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<MainPageState> buildEffect() {
  return combineEffects(<Object, Effect<MainPageState>>{
    MainPageAction.action: _onAction,
    MainPageAction.openDrawer: _onOpenDrawer,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

ReceivePort _port = ReceivePort();
void _onAction(Action action, Context<MainPageState> ctx) {}
void _onInit(Action action, Context<MainPageState> ctx) async {
  await ApiHelper.init();
  var _user = await FirebaseAuth.instance.currentUser();
  if (_user != null)
    GlobalStore.store.dispatch(GlobalActionCreator.setUser(_user));
  FirebaseMessaging().configure(
      onMessage: (_) async => print('233333'),
      onResume: (message) async {
        _push(message, ctx);
      },
      onLaunch: (message) async {
        _push(message, ctx);
      });
  _bindBackgroundIsolate();

  FlutterDownloader.registerCallback(DownloaderCallBack.callback);

  await _checkAppUpdate(ctx);
}

void _onDispose(Action action, Context<MainPageState> ctx) {
  _unbindBackgroundIsolate();
}

Future _push(Map<String, dynamic> message, Context<MainPageState> ctx) async {
  if (message['data'] != null) {
    final _messageData = message['data'];
    var data = {
      _messageData['type'] == 'movie' ? 'id' : 'tvid':
          int.parse(_messageData['id'].toString()),
      'bgpic': _messageData['type'] == 'movie'
          ? _messageData['posterPic']
          : _messageData['bgPic'],
      _messageData['type'] == 'movie' ? 'title' : 'name': _messageData['name'],
      'posterpic': _messageData['posterPic']
    };
    Page page =
        _messageData['type'] == 'movie' ? MovieDetailPage() : TVDetailPage();
    await Navigator.of(ctx.state.scaffoldKey.currentContext)
        .push(PageRouteBuilder(pageBuilder: (context, animation, secAnimation) {
      return FadeTransition(
        opacity: animation,
        child: page.buildPage(data),
      );
    }));
  }
}

void _onOpenDrawer(Action action, Context<MainPageState> ctx) {
  ctx.state.scaffoldKey.currentState.openEndDrawer();
}

Future _checkAppUpdate(Context<MainPageState> ctx) async {
  if (!Platform.isAndroid) return;

  final _preferences = await SharedPreferences.getInstance();
  String _ignoreVersion = _preferences.getString('IgnoreVersion') ?? '';

  final _packageInfo = await PackageInfo.fromPlatform();
  final _github = GithubApi();
  final _result = await _github.checkUpdate();
  if (_result != null) {
    if (_ignoreVersion == _result.tagName) return;
    final _shouldUpdate = VersionComparison()
        .compare(_packageInfo.version, _result.tagName);
    final _apk = _result.assets.singleWhere(
        (e) => e.contentType == 'application/vnd.android.package-archive');

    if (_apk != null && _shouldUpdate) {
      await showDialog(
          context: ctx.context,
          child: UpdateInfoDialog(
            version: _result.tagName,
            describe: _result.body,
            packageSize: (_apk.size / 1048576),
            downloadUrl: _apk.browserDownloadUrl,
          ));
    }
  }
}

void _bindBackgroundIsolate() {
  bool isSuccess = IsolateNameServer.registerPortWithName(
      _port.sendPort, 'downloader_send_port');
  if (!isSuccess) {
    _unbindBackgroundIsolate();
    _bindBackgroundIsolate();
    return;
  }
  _port.listen((dynamic data) async {
    String id = data[0];
    DownloadTaskStatus status = data[1];
    //int progress = data[2];
    if (status == DownloadTaskStatus.complete)
      await FlutterDownloader.open(taskId: id);
    print('UI Isolate Callback: $data');
  });
}

void _unbindBackgroundIsolate() {
  IsolateNameServer.removePortNameMapping('downloader_send_port');
}
