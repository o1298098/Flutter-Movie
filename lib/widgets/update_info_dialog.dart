import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:movie/actions/adapt.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateInfoDialog extends StatelessWidget {
  final String version;
  final String describe;
  final double packageSize;
  final String downloadUrl;
  const UpdateInfoDialog(
      {@required this.version,
      @required this.describe,
      this.packageSize,
      this.downloadUrl});

  void _startDownload(BuildContext context) async {
    try {
      final _localPath =
          (await _findLocalPath()) + Platform.pathSeparator + 'Download';
      final _savedDir = Directory(_localPath);
      bool hasExisted = await _savedDir.exists();
      if (!hasExisted) {
        _savedDir.create();
      }
      final _taskId = await FlutterDownloader.enqueue(
        url: downloadUrl,
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true,
      );
      print(_taskId);
    } on Exception catch (_) {
      print(_);
    }
    Navigator.of(context).pop();
  }

  _ignoreVersion(BuildContext context) async {
    SharedPreferences _p = await SharedPreferences.getInstance();
    _p.setString('IgnoreVersion', version);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        contentPadding: EdgeInsets.only(bottom: Adapt.px(20)),
        titlePadding: EdgeInsets.symmetric(
            horizontal: Adapt.px(40), vertical: Adapt.px(30)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Adapt.px(20))),
        title: Text('New Version'),
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
              //constraints: BoxConstraints(minHeight: Adapt.px(350)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    version,
                    style: TextStyle(
                        fontSize: Adapt.px(28), fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: Adapt.px(20)),
                  Text(describe),
                  SizedBox(height: Adapt.px(50)),
                  Text('package size: ${packageSize.toStringAsFixed(2)} MB')
                ],
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
            child: Row(children: [
              Expanded(child: SizedBox()),
              TextButton(
                onPressed: () => _ignoreVersion(context),
                child: Text(
                  'ignore',
                  style: TextStyle(color: Colors.grey, fontSize: Adapt.px(30)),
                ),
              ),
              TextButton(
                  onPressed: () => _startDownload(context),
                  child: Text(
                    'download',
                    style:
                        TextStyle(color: Colors.blue, fontSize: Adapt.px(30)),
                  ))
            ]),
          )
        ]);
  }
}

Future<String> _findLocalPath() async {
  final directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();
  return directory.path;
}
