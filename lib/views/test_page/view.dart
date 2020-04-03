//import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/customwidgets/web_torrent_player.dart';

import 'state.dart';

Widget buildView(
    TestPageState state, Dispatch dispatch, ViewService viewService) {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: state.themeColor,
        title: Text('${state?.locale?.languageCode}'),
      ),
      body: Column(
        children: <Widget>[
          WebTorrentPlayer(
            url:
                'magnet:?xt=urn:btih:4b4aabcfac816b30338b54a99321d02bb3a7a4a8&dn=Jumanji.The.Next.Level.2019.WEBRip.x264-ION10&tr=http%3A%2F%2Ftracker.trackerfix.com%3A80%2Fannounce&tr=udp%3A%2F%2F9.rarbg.me%3A2720&tr=udp%3A%2F%2F9.rarbg.to%3A2770&tr=wss%3A%2F%2Ftracker.btorrent.xyz&tr=wss%3A%2F%2Ftracker.fastcast.nz&tr=wss%3A%2F%2Ftracker.openwebtorrent.com',
          ),
          Text(Adapt.screenW().toString()),
          RaisedButton(
              onPressed: () {
                _firebaseMessaging.requestNotificationPermissions();
                _firebaseMessaging.configure();
                _firebaseMessaging.autoInitEnabled();
                _firebaseMessaging.subscribeToTopic('test');
                _firebaseMessaging.getToken().then((value) => print(value));
              },
              child: Text('test')),
        ],
      ));
}
