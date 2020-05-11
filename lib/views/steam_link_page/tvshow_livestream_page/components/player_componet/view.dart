import 'package:chewie/chewie.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/customwidgets/sliverappbar_delegate.dart';
import 'package:movie/customwidgets/web_torrent_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'state.dart';

Widget buildView(
    TvPlayerState state, Dispatch dispatch, ViewService viewService) {
  final double _height = Adapt.screenW() * 9 / 16;
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
            _Player(
              streamAddress: state.streamAddress,
              streamLinkTypeName: state.streamLinkTypeName,
              chewieController: state.chewieController,
              youtubePlayerController: state.youtubePlayerController,
            )
          ],
        ),
      ),
    ),
  );
}

class _Player extends StatelessWidget {
  final String streamLinkTypeName;
  final String streamAddress;
  final ChewieController chewieController;
  final YoutubePlayerController youtubePlayerController;
  const _Player(
      {this.chewieController,
      this.streamAddress,
      this.streamLinkTypeName,
      this.youtubePlayerController});
  @override
  Widget build(BuildContext context) {
    final double _height = Adapt.screenW() * 9 / 16;
    String key = streamLinkTypeName ?? '';
    switch (key) {
      case 'YouTube':
        return YoutubePlayer(
          controller: youtubePlayerController,
          topActions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: Adapt.px(80),
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
          progressIndicatorColor: Colors.red,
          progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        );
      case 'WebView':
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: InAppWebView(
            key: ValueKey(streamAddress),
            initialHeaders: {},
            initialOptions: InAppWebViewWidgetOptions(
                android: AndroidInAppWebViewOptions(
                  supportMultipleWindows: false,
                ),
                crossPlatform: InAppWebViewOptions(
                  useShouldOverrideUrlLoading: true,
                  javaScriptCanOpenWindowsAutomatically: false,
                  debuggingEnabled: true,
                )),
            onWebViewCreated: (controller) {
              controller.loadUrl(url: streamAddress);
            },
            shouldOverrideUrlLoading:
                (controller, shouldOverrideUrlLoadingRequest) {
              if (shouldOverrideUrlLoadingRequest.url != streamAddress) {
                controller.stopLoading();
              }
              return;
            },
          ),
        );
      case 'other':
        return Container(
          color: Colors.black,
          alignment: Alignment.bottomCenter,
          height: _height,
          child: chewieController != null
              ? Chewie(
                  key: ValueKey(chewieController), controller: chewieController)
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
          key: ValueKey(streamAddress),
          url: streamAddress,
        );
      default:
        return Container(
          height: _height,
          color: Colors.black,
        );
    }
  }
}
