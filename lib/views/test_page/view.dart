import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/customwidgets/web_torrent_player.dart';

import 'state.dart';

Widget buildView(
    TestPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: state.themeColor,
        title: Text('${state?.locale?.languageCode}'),
      ),
      body: Column(
        children: <Widget>[
          /* _buildBody(viewService.context),
          InkWell(
            onTap: () {
              GlobalStore.store
                  .dispatch(GlobalActionCreator.onchangeThemeColor());
              GlobalStore.store
                  .dispatch(GlobalActionCreator.changeLocale(Locale('zh')));
            },
            //dispatch(TestPageActionCreator.googleSignIn()),
            child: Container(
              padding: EdgeInsets.all(Adapt.px(30)),
              color: Colors.amber,
              child: Text(I18n.of(viewService.context).account),
            ),
          ),
          SizedBox(height: Adapt.px(30)),
          InkWell(
            onTap: () => dispatch(TestPageActionCreator.inputTapped()),
            //dispatch(TestPageActionCreator.googleSignIn()),
            child: Container(
              padding: EdgeInsets.all(Adapt.px(30)),
              color: Colors.amber,
              child: Text('input'),
            ),
          ),
          SizedBox(height: Adapt.px(30)),
          Container(
            width: Adapt.px(100),
            height: Adapt.px(100),
            decoration: BoxDecoration(
              color: Color(0xFFF0F0F0),
              boxShadow: [
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(-Adapt.px(8), -Adapt.px(8)),
                    blurRadius: Adapt.px(10)),
                BoxShadow(
                    color: Colors.grey[300],
                    offset: Offset(Adapt.px(10), Adapt.px(10)),
                    blurRadius: Adapt.px(10))
              ],
            ),
          ),*/
          WebTorrentPlayer(
            url:
                'magnet:?xt=urn:btih:4b4aabcfac816b30338b54a99321d02bb3a7a4a8&dn=Jumanji.The.Next.Level.2019.WEBRip.x264-ION10&tr=http%3A%2F%2Ftracker.trackerfix.com%3A80%2Fannounce&tr=udp%3A%2F%2F9.rarbg.me%3A2720&tr=udp%3A%2F%2F9.rarbg.to%3A2770&tr=wss%3A%2F%2Ftracker.btorrent.xyz&tr=wss%3A%2F%2Ftracker.fastcast.nz&tr=wss%3A%2F%2Ftracker.openwebtorrent.com',
          ),
          Text(Adapt.screenW().toString()),
        ],
      ));
}
