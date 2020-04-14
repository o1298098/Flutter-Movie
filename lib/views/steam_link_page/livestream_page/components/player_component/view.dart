import 'package:chewie/chewie.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/customwidgets/sliverappbar_delegate.dart';
import 'package:movie/customwidgets/web_torrent_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as youtube;

import 'state.dart';

Widget buildView(
    PlayerState state, Dispatch dispatch, ViewService viewService) {
  final double _height = Adapt.screenW() * 9 / 16;

  Widget _getPlayer() {
    String key = state.streamLinkTypeName ?? '';
    switch (key) {
      case 'YouTube':
        return youtube.YoutubePlayer(
          controller: state.youtubePlayerController,
          topActions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: Adapt.px(80),
              ),
              onPressed: () => Navigator.of(viewService.context).pop(),
            )
          ],
          progressIndicatorColor: Colors.red,
          progressColors: youtube.ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        );
      case 'WebView':
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: InAppWebView(
              key: ValueKey(state.streamAddress),
              initialUrl: state.streamAddress,
              initialHeaders: {},
              initialOptions: InAppWebViewWidgetOptions(
                  crossPlatform: InAppWebViewOptions(
                debuggingEnabled: true,
              ))),
        );
      case 'other':
        return Container(
          color: Colors.black,
          alignment: Alignment.bottomCenter,
          height: _height,
          child: state.chewieController != null
              ? Chewie(
                  key: ValueKey(state.chewieController),
                  controller: state.chewieController)
              : SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                ),
        );
      case 'Torrent':
        return WebTorrentPlayer(
          key: ValueKey(state.streamAddress),
          url: state.streamAddress,
        );
      default:
        return Container(
          height: _height,
          color: Colors.black,
        );
    }
  }

  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverAppBarDelegate(
        maxHeight: _height + Adapt.padTopH(),
        minHeight: _height + Adapt.padTopH(),
        child: Container(
          color: Colors.black,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.black,
                height: Adapt.padTopH(),
              ),
              _getPlayer()
            ],
          ),
        )),
  );
}
